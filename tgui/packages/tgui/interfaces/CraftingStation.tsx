import { uniq } from 'common/collections';
import { round } from 'common/math';
import { toTitleCase } from 'common/string';
import { useBackend, useSharedState } from 'tgui/backend';
import { Box, Button, Section, Stack, Tabs } from 'tgui/components';
import { Window } from 'tgui/layouts';

import { MaterialAccessBar } from './Fabrication/MaterialAccessBar';
import { Material } from './Fabrication/Types';

type Recipe = {
  name: string;
  type: string;
  category: string;
  subcategory: string | null;
  cost: {
    [material: string]: number;
  };
};

type Data = {
  craftable_recipes: string[];
  recipes: Recipe[];
  materials: Material[];
};

const categorySortingOrder = [
  'barrels',
  'grips',
  'mechanisms',
  'small arms ammo',
  'long arms ammo',
  'misc ammo',
];

const subcategorySortingOrder = [
  '9mm',
  '10mm magnum',
  '12mm heavy pistol',
  'shotgun shell',
  '6.5mm carbine',
  '7.62mm rifle',
  '8.6mm heavy rifle',
  '14.5mm anti materiel',
  'flare shell',
  '17mm rolled shot',
  '19mm explosive',
  'small arms',
  'long arms',
  'cheap small arms',
  'cheap long arms',
];

export const CraftingStation = (props) => {
  const { act, data } = useBackend<Data>();

  const { craftable_recipes, recipes, materials } = data;

  const categories = uniq(recipes.map((r) => r.category)).sort((a, b) => {
    let alower = a.toLowerCase();
    let blower = b.toLowerCase();
    if (
      categorySortingOrder.includes(alower) &&
      categorySortingOrder.includes(blower)
    ) {
      return (
        categorySortingOrder.indexOf(alower) -
        categorySortingOrder.indexOf(blower)
      );
    } else {
      return alower.localeCompare(blower);
    }
  });

  const [selectedCategory, setSelectedCategory] = useSharedState(
    'selectedCategory',
    categories[0],
  );

  const recipesInThisCategory = recipes.filter(
    (recipe) => recipe.category === selectedCategory,
  );

  const subCategories = uniq(
    recipesInThisCategory.map((recipe) => recipe.subcategory || 'Other'),
  ).sort((a, b) => {
    let alower = a.toLowerCase();
    let blower = b.toLowerCase();
    if (
      subcategorySortingOrder.includes(alower) &&
      subcategorySortingOrder.includes(blower)
    ) {
      return (
        subcategorySortingOrder.indexOf(alower) -
        subcategorySortingOrder.indexOf(blower)
      );
    } else {
      return alower.localeCompare(blower);
    }
  });

  const [selectedSubCategory, setSelectedSubCategory] = useSharedState(
    'selectedSubCategory',
    subCategories[0],
  );

  const finalRecipes = recipesInThisCategory.filter(
    (recipe) => selectedSubCategory === (recipe.subcategory || 'Other'),
  );

  return (
    <Window width={620} height={600}>
      <Window.Content>
        <Section
          title="Crafting"
          fill
          height={materials.length > 0 ? '85%' : '100%'}
        >
          <Stack fill vertical>
            <Stack.Item>
              <Tabs fluid>
                {categories.map((cat) => (
                  <Tabs.Tab
                    key={cat}
                    selected={cat === selectedCategory}
                    onClick={() => {
                      setSelectedCategory(cat);
                      // Must reset subcategory to default or could end up trapping the user
                      setSelectedSubCategory(
                        recipes
                          .filter((r) => r.category === cat)
                          .map((r) => r.subcategory || 'Other')
                          .sort((a, b) => {
                            let alower = a.toLowerCase();
                            let blower = b.toLowerCase();
                            if (
                              subcategorySortingOrder.includes(alower) &&
                              subcategorySortingOrder.includes(blower)
                            ) {
                              return (
                                subcategorySortingOrder.indexOf(alower) -
                                subcategorySortingOrder.indexOf(blower)
                              );
                            } else {
                              return alower.localeCompare(blower);
                            }
                          })[0],
                      );
                    }}
                  >
                    {cat}
                  </Tabs.Tab>
                ))}
              </Tabs>
              {/* If the only category is "Other" then don't bother showing the tabs */}
              {subCategories.length > 1 && (
                <Tabs fluid mt={-0.5} mb={0}>
                  {subCategories.map((cat) => (
                    <Tabs.Tab
                      key={cat}
                      selected={cat === selectedSubCategory}
                      onClick={() => setSelectedSubCategory(cat)}
                    >
                      {cat}
                    </Tabs.Tab>
                  ))}
                </Tabs>
              )}
            </Stack.Item>
            <Stack.Item grow>
              <Section fill style={{ overflowY: 'auto' }}>
                {finalRecipes.map((recipe) => (
                  <Stack
                    key={recipe.name}
                    className="candystripe"
                    p={1}
                    align="center"
                  >
                    <Stack.Item grow>
                      <Stack vertical>
                        <Stack.Item fontSize={1.2} color="label">
                          {recipe.name}
                        </Stack.Item>
                        <Stack.Item
                          textColor={
                            craftable_recipes.includes(recipe.type) ? '' : 'bad'
                          }
                        >
                          {Object.entries(recipe.cost).map(
                            ([name, cost], index, arr) => (
                              <Box
                                key={name}
                                inline
                                mr={index === arr.length - 1 ? 0 : 0.5}
                              >
                                {toTitleCase(name)} ({round(cost, 2)})
                                {index === arr.length - 1 ? '' : ', '}
                              </Box>
                            ),
                          )}
                        </Stack.Item>
                      </Stack>
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="hammer"
                        disabled={!craftable_recipes.includes(recipe.type)}
                        onClick={() => act('craft', { type: recipe.type })}
                      >
                        Craft
                      </Button>
                    </Stack.Item>
                  </Stack>
                ))}
              </Section>
            </Stack.Item>
          </Stack>
        </Section>
        {materials.length > 0 && (
          <Section>
            <MaterialAccessBar
              availableMaterials={materials}
              disableStackEjection
              onEjectRequested={(material, qty) => {
                act('eject', { material: material.name });
              }}
            />
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};
