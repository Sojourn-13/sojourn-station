import { filter, sortBy } from '../../common/collections';
import { BooleanLike } from '../../common/react';
import { createSearch, decodeHtmlEntities } from '../../common/string';
import { useBackend, useLocalState } from '../backend';
import {
  Box,
  Button,
  Divider,
  Input,
  Section,
  Stack,
  Tabs,
} from '../components';
import { Window } from '../layouts';
import { SearchBar } from './Fabrication/SearchBar';

const GroupTitle = ({ title }) => {
  return (
    <Stack my={1}>
      <Stack.Item grow>
        <Divider />
      </Stack.Item>
      <Stack.Item color={'gray'}>{title}</Stack.Item>
      <Stack.Item grow>
        <Divider />
      </Stack.Item>
    </Stack>
  ) as any;
};

export type CraftingStep = {
  // Amount of resource needed for this step
  amt: number;
  // The resource OR tool needed
  tool_name: string;
  // Icon url
  icon: string;
  // Used to indicate if tool_name is a material stack, used for correct pluralization
  reqed_material: BooleanLike;
};

export const CraftingStep = (props: { step: CraftingStep }, context) => {
  const { step } = props;

  const { amt, tool_name, icon, reqed_material } = step;

  if (amt == 0) {
    return (
      <Stack align="center">
        <Stack.Item>
          <img src={icon} />
        </Stack.Item>
        <Stack.Item>Apply {tool_name}</Stack.Item>
      </Stack>
    );
    // correct pluralization for non-stacks
  } else if (amt == 1 && !reqed_material) {
    return (
      <Stack align="center">
        <Stack.Item>
          <img src={icon} />
        </Stack.Item>
        <Stack.Item>Attach {tool_name}</Stack.Item>
      </Stack>
    );
  } else {
    return (
      <Stack align="center">
        <Stack.Item>
          <img src={icon} />
        </Stack.Item>
        <Stack.Item>
          Attach {amt} {tool_name}
        </Stack.Item>
      </Stack>
    );
  }
};

export const CompactCraftingStep = (props: { step: CraftingStep }, context) => {
  const { step } = props;

  const { amt, tool_name, icon, reqed_material } = step;

  if (amt == 0) {
    return <>{tool_name}</>;
    // correct pluralization for non-stacks
  } else if (amt == 1 && !reqed_material) {
    return <>{tool_name}</>;
  } else {
    return (
      <>
        {amt} {tool_name}
      </>
    );
  }
};

export type CraftingRecipe = {
  name: string;
  ref: string;
  icon: string;
  batch: BooleanLike;
  desc: string;
  steps: CraftingStep[];
};

export const CraftingRecipe = (
  props: { recipe: CraftingRecipe; compact: boolean; admin: boolean },
  context
) => {
  const { act } = useBackend(context);
  const { recipe, compact, admin } = props;

  return (
    <Section>
      <Stack>
        <Stack.Item>
          <img src={recipe.icon} />
        </Stack.Item>
        <Stack.Item grow>
          <Box style={{ 'text-transform': 'capitalize' }}>{recipe.name}</Box>
          {!compact && <Box color="grey">{recipe.desc}</Box>}
          <Box color={compact ? 'grey' : ''}>
            {!compact && <GroupTitle title="Steps" />}
            {recipe.steps.map((step, idx) => {
              if (compact) {
                return (
                  <>
                    <CompactCraftingStep step={step} />
                    {idx !== recipe.steps.length ? ', ' : ''}
                  </>
                );
              } else {
                return (
                  <>
                    <CraftingStep step={step} />
                  </>
                );
              }
            })}
          </Box>
        </Stack.Item>
        <Stack.Item>
          <Stack vertical={!compact}>
            <Stack.Item>
              <Button
                icon="hammer"
                tooltip="Craft"
                onClick={() => act('build', { ref: recipe.ref })}
              />
            </Stack.Item>
            <Stack.Item>
              {admin && (
                <Button
                  icon="bug"
                  tooltip="View Variables"
                  onClick={() => act('view_variables', { ref: recipe.ref })}
                />
              )}
            </Stack.Item>
          </Stack>
        </Stack.Item>
        {recipe.batch ? (
          compact ? (
            <Stack.Item>
              <Stack>
                <Stack.Item>
                  <Button
                    fluid
                    textAlign="right"
                    tooltip="Craft 5"
                    onClick={() =>
                      act('build', { ref: recipe.ref, amount: 5 })
                    }>
                    5
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    fluid
                    textAlign="right"
                    tooltip="Craft 10"
                    onClick={() =>
                      act('build', { ref: recipe.ref, amount: 10 })
                    }>
                    10
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    fluid
                    textAlign="right"
                    tooltip="Craft 25"
                    onClick={() =>
                      act('build', { ref: recipe.ref, amount: 25 })
                    }>
                    25
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    fluid
                    textAlign="right"
                    tooltip="Craft 50"
                    onClick={() =>
                      act('build', { ref: recipe.ref, amount: 50 })
                    }>
                    50
                  </Button>
                </Stack.Item>
              </Stack>
            </Stack.Item>
          ) : (
            <Stack.Item>
              <Stack vertical>
                <Stack.Item>
                  <Button
                    fluid
                    textAlign="right"
                    tooltip="Craft 5"
                    onClick={() =>
                      act('build', { ref: recipe.ref, amount: 5 })
                    }>
                    5
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    fluid
                    textAlign="right"
                    tooltip="Craft 10"
                    onClick={() =>
                      act('build', { ref: recipe.ref, amount: 10 })
                    }>
                    10
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    fluid
                    textAlign="right"
                    tooltip="Craft 25"
                    onClick={() =>
                      act('build', { ref: recipe.ref, amount: 25 })
                    }>
                    25
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    fluid
                    textAlign="right"
                    tooltip="Craft 50"
                    onClick={() =>
                      act('build', { ref: recipe.ref, amount: 50 })
                    }>
                    50
                  </Button>
                </Stack.Item>
              </Stack>
            </Stack.Item>
          )
        ) : (
          ''
        )}
      </Stack>
    </Section>
  );
};

type Data = {
  crafting_recipes: {
    [key: string]: CraftingRecipe[];
  };
  is_admin: BooleanLike;
};

export const CraftMenu = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { crafting_recipes, is_admin } = data;

  // Filter out empty categories
  const available_categories = Object.keys(crafting_recipes).filter(
    (category) => crafting_recipes[category].length !== 0
  );

  // Total recipe count
  const recipeCount = available_categories
    .map((category) => crafting_recipes[category].length)
    .reduce((s, a) => s + a, 0);

  // -- State --
  // Compact mode
  const [showCompact, setShowCompact] = useLocalState(
    context,
    'showCompact',
    false
  );

  // Search text
  const [searchText, setSearchText] = useLocalState(context, 'searchText', '');

  const searchName = createSearch(
    searchText,
    (item: CraftingRecipe) => item.name
  );

  // Pagination
  const [pages, setPages] = useLocalState(context, 'pages', 1);

  const pageSize =
    searchText.length > 0 ? (showCompact ? 20 : 10) : showCompact ? 60 : 30;
  const displayLimit = pageSize * pages;

  // Selected Category
  const [currentCategory, setCurrentCategory] = useLocalState(
    context,
    'currentCategory',
    available_categories[0]
  );

  // -- Filter and search recipes --
  let recipes = crafting_recipes[currentCategory];

  if (searchText !== '') {
    recipes = available_categories
      .flatMap((category) => crafting_recipes[category])
      .filter(searchName);
  }

  recipes = sortBy((recipe: CraftingRecipe) => recipe.name.toUpperCase())(
    recipes
  );

  // -- UI --
  return (
    <Window width={800} height={450}>
      <Window.Content>
        <Stack fill>
          <Stack.Item width="30%">
            <Section fill>
              <Stack fill vertical justify="space-between">
                <Stack.Item>
                  <Input
                    placeholder={'Search in ' + recipeCount + ' recipes...'}
                    fluid
                    value={searchText}
                    onInput={(e, value) => {
                      setPages(1);
                      setSearchText(value);
                    }}
                  />
                </Stack.Item>
                <Stack.Item grow>
                  <Box height="100%" pt={1} pr={1} overflowY="auto">
                    <Tabs fluid vertical>
                      {available_categories.map((category) => (
                        <Tabs.Tab
                          selected={category == currentCategory}
                          onClick={() => {
                            setPages(1);
                            setCurrentCategory(category);
                            if (searchText.length > 0) {
                              setSearchText('');
                            }
                          }}>
                          {category} ({crafting_recipes[category].length})
                        </Tabs.Tab>
                      ))}
                    </Tabs>
                  </Box>
                </Stack.Item>
                <Stack.Item>
                  <Divider />
                  {/* <Button.Checkbox fluid content="Craftable Only" /> */}
                  <Button.Checkbox
                    fluid
                    content="Compact List"
                    checked={showCompact}
                    onClick={() => setShowCompact(!showCompact)}
                  />
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
          <Stack.Item grow my={-1}>
            <Box height="100%" pr={1} pt={1} mr={-1} overflowY="auto">
              {recipes.slice(0, displayLimit).map((recipe) => (
                <CraftingRecipe
                  recipe={recipe}
                  compact={showCompact}
                  admin={!!is_admin}
                />
              ))}
              {recipes.length > displayLimit && (
                <Section
                  mb={2}
                  textAlign="center"
                  style={{ cursor: 'pointer' }}
                  onClick={() => setPages(pages + 1)}>
                  Load {Math.min(pageSize, recipes.length - displayLimit)}{' '}
                  more...
                </Section>
              )}
            </Box>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
