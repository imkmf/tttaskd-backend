c_laptop = Context.create(name: 'laptop')
c_home = Context.create(name: 'home')

p_software = Project.create(name: 'Software ideas')
p_house = Project.create(name: 'Around the house')

Task.create(
  name: 'Write taskd',
  context: c_laptop,
  project: p_software,
  due_at: (DateTime.now + 7.days)
)
Task.create(
  name: 'Take out garbage',
  project: p_house,
  context: c_home,
  due_at: (DateTime.now + 7.days),
)
Task.create(
  name: 'Do the thing',
  due_at: (DateTime.now + 1.days)
)
