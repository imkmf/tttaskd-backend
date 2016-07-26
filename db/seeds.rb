user = User.last

if user
  c_laptop = Context.create(name: 'laptop', user: user)
  c_home = Context.create(name: 'home', user: user)

  p_software = Project.create(name: 'Software ideas', user: user)
  p_house = Project.create(name: 'Around the house', user: user)

  Task.create(
    name: 'Write taskd',
    context: c_laptop,
    project: p_software,
    due_at: (DateTime.now + 7.days),
    user: user
  )
  Task.create(
    name: 'Take out garbage',
    project: p_house,
    context: c_home,
    due_at: (DateTime.now + 7.days),
    user: user
  )
  Task.create(
    name: 'Do the thing',
    due_at: (DateTime.now + 1.days),
    user: user
  )
else
  puts 'no user, cannot create data'
end
