# Define the block that will return true or false based on actor. Registers a
# group named admins which saves the block to be called later.
Flipper.register(:admins) do |actor, context|
  actor.respond_to?(:admin?) && actor.admin?
end
