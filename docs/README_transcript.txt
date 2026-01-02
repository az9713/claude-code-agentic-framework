https://www.youtube.com/watch?v=fop_yxV-mPo&t=34s

What if your agents could run your codebase BETTER than you ever could? 🤯

This is the codebase singularity - the moment you realize you trust your AI agents to ship more than you trust yourself or your team.

In this sneak peak from Agentic Horizon Lesson 6, we break down the three concrete classes of the agentic layer and show you exactly how to scale from a basic setup to a full orchestrator-driven system.

---

IndyDevDan here, the final lesson is here: Agentic Horizon Lesson 6 (TAC 14) is officially live on (link below).

Huge thanks to every engineer that's a member and has taken Tactical Agentic Coding and Agentic Horizon.

For all non-members, this video is a sneak peak of the full lesson available to Agentic Horizon members.

If you're interested you can unlock this lesson and others by purchasing Tactical Agentic Coding AND Agentic Horizon.

Let me be clear, TAC and AH is not for beginners. See the landing page for more details.

---

💡 BUILD YOUR AGENTIC LAYER
Tactical Agentic Coding: https://agenticengineer.com/tactical-...

🔥 The agentic layer is the new ring around your codebase where you teach your agents to operate your application on your behalf. When you build this layer correctly, something incredible happens: your codebase starts running itself.

🚀 In this video, we break down the three concrete classes of the agentic layer and show you exactly how to scale from a basic setup to a full orchestrator-driven system. From class one grade one (just a prime prompt and memory files) all the way to class three with multi-agent orchestration - we're mapping the entire journey.

🛠️ Watch as we demonstrate an orchestrator agent kicking off AI developer workflows, running plan-build-review-fix cycles, and building entire applications in one shot. This is tactical agentic coding taken to the next level.

💡 Key Concepts Covered:

Agentic Layer: The new outer ring of your codebase where agents drive your engineering
Codebase Singularity: The moment your agents run your code better than you can
Agentic Horizon: The future where your codebase runs itself
Multi-Agent Systems: Orchestrator agents controlling AI developer workflows
Agent Orchestration: Building systems where agents coordinate and execute complex tasks
Classes and Grades: A framework for measuring your agentic layer's power

🌟 Whether you're just starting with a prime prompt or building sophisticated multi-agent systems, understanding the agentic layer is the highest ROI action for any engineer in the age of AI. We break down every grade and class from 1 to 5, showing you exactly what your codebase structure should look like at each level.

⚡ From memory files to custom tools, from skills and MCP servers to closed-loop prompts that self-correct - this is your sneak peak of the complete guide to building the agentic layer that transforms how you engineer forever.


Transcript


Search in video
0:00
There is one mental framework that sits
0:03
at the center. An idea so important that
0:06
if you capture it, it can change the way
0:08
you engineer forever. The agentic layer.
0:12
This is the new ring around your
0:15
codebase where you teach your agents to
0:17
operate your application on your behalf
0:20
as well and even better than you and
0:23
your team ever could. Focusing on
0:25
building the agentic layer of your
0:27
codebase is the highest return on
0:30
investment action for any engineer in
0:33
the age of agents we live in. Why is
0:36
that? As you know, when you scale your
0:38
compute, you scale your impact. We're
0:42
not just AI coding anymore. Our agents
0:44
can take actions on our behalf. And this
0:47
has changed engineering forever. Once
0:50
you've built a sufficiently powerful
0:52
agentic layer, something will happen.
0:55
The codebase singularity. In this
0:58
moment, you, the engineer, will realize
1:00
one simple fact. My agents can now run
1:04
my codebase better than I can. I trust
1:07
them to ship more than I trust myself or
1:10
my team. Nothing ships to production
1:12
without my teams of agents. Yes, this
1:16
might sound crazy. It might sound far
1:18
out, but if you've been pushing what you
1:20
can do with agents, if you've been
1:22
putting these tactics to work already,
1:24
maybe you already see this future on the
1:27
horizon, the agentic horizon. I can tell
1:30
you this for certain right now. There is
1:32
an agentic layer that could exist inside
1:35
your codebase so powerful that your
1:39
codebase runs itself. The only question
1:42
now is, do you know how to build it? As
1:46
we work through building agentic layers,
1:49
keep this idea in your mind and think
1:52
through what it would take for you to
1:54
trust your agents to run your codebase
1:57
better than you could from prompt to
2:00
production. In this lesson, we're going
2:01
to put together the missing pieces and
2:04
see how we can attain the codebase
2:06
singularity.
2:08
[Music]
2:11
There are three concrete classes of the
2:15
agentic layer. Class one, class 2, and
2:18
class three. Each defined by a unique
2:21
element that makes them distinct from
2:23
the rest. Our whole goal here is to look
2:26
at the components, the raw elements that
2:28
make up the new ring around your
2:30
codebase where you have agents drive
2:33
your engineering experience and you
2:35
drive your agents. the green squares
2:38
here, the outer layer, this is the new
2:40
aentic layer. The inner layer here,
2:43
right, these dark squares, this is going
2:46
to be your application layer. And we're
2:48
bundling a ton of things underneath your
2:50
application layer. We're talking about
2:51
your database, your front end, your
2:53
backend, your scripts, all the
2:55
application stuff, even your DevOps
2:57
stuff, right? This all goes underneath
2:59
the application layer. Why is that? It's
3:01
because we want to be able to bundle
3:03
your different repositories underneath
3:06
your agentic layer so that we can do
3:08
something like this. Code bases often
3:11
contain more than one application. So by
3:14
bundling your agentic layer around your
3:16
applications, your agents can
3:18
effectively see everything. Every class
3:21
is going to have one to n grades that
3:24
will give you a rough understanding of
3:26
how powerful your agentic layer is.
3:28
You're going to be able to quickly
3:30
identify where you are as we move
3:31
through classes and grades so that you
3:34
can make improvements and get to that
3:36
next level. And then once you reach the
3:38
limit of a certain class, look to make
3:40
that next jump uniquely identified by a
3:43
new dimension that we'll talk about as
3:45
we progress from grade to grade from
3:47
class to class all the way up to class
3:49
three and the final grade. Now, let's
3:53
start by looking at a powerful version
3:55
of a class 3 agentic system with an
3:58
orchestrator guiding the workflow.
4:00
You've seen powerful systems like this
4:02
in our previous two agentic horizon
4:05
lessons. What we're going to do now is
4:07
run two brand new workflows and combine
4:10
some really big ideas. I'm going to open
4:12
up the prompt interface here as usual.
4:14
And you'll notice we have one new
4:16
section. Our orchestrator agent can now
4:19
kick off AI developer workflows. I'll
4:22
paste in this prompt here. And I'm
4:23
commanding the orchestrator agent to
4:25
kick off this specific workflow in this
4:27
specific directory with just a single
4:30
simple prompt. We're not over
4:32
complicating this. I just want to show
4:33
you so that you have a concrete vision
4:35
of the types of systems you can build
4:38
out. So we're going to fire this off
4:39
here. Let's go ahead and run another
4:41
build out a markdown preview application
4:44
here in one shot with our plan, build,
4:47
review, and fix. And this is an AI
4:49
developer workflow. So the orchestrator
4:51
doesn't need to do anything, right? This
4:52
runs end to end. We're going to run one
4:55
more workflow here. And then I want to
4:56
show you something awesome. You've seen
4:58
the generic log view. We have pushed our
5:00
orchestrator to be able to control AI
5:03
developer workflows. We now have two
5:06
workflows running. So plan, build,
5:08
review, fix, and just a simple plan
5:09
build. We have given our orchestrator
5:11
agent the ability to run arbitrary
5:14
endtoend workflows. Now let's dial in
5:17
and start from zero, right? Let's reset
5:20
because we don't start here. We don't
5:21
start at class 3. We don't start with
5:23
powerful orchestration systems. We start
5:25
with nothing. So as mentioned, every
5:29
single codebase should now have these
5:31
two key components. The application
5:33
layer and the agentic layer. These two
5:36
squares here represent a brand new
5:38
codebase. Now, oftent times you'll be
5:40
operating in an existing codebase that
5:42
will look like this, right? You'll
5:43
already have some pieces, right?
5:46
Modules, files of your application layer
5:48
and then you'll start adding on your
5:50
agentic layer around your codebase. Now,
5:53
what does this really look like? Let's
5:56
start from a green field brand new
5:57
application just to make this all clear.
6:00
What exactly is in our agentic layer?
6:03
This is our class one grade one agentic
6:06
layer. This the thinnest possible
6:09
agentic layer. You can have a small
6:10
amount of code and you have a prime
6:12
prompt andor memory files. It doesn't
6:15
get thinner than this. If you have this,
6:18
you technically have an agentic layer.
6:20
Now, let's dive into a concrete codebase
6:23
structure to see what this looks like.
6:24
This is an example project structure.
6:26
We're going to work through several of
6:27
these to make it absolutely clear what
6:29
it looks like to have an agentic layer
6:32
surrounding your application layer. All
6:33
right, so we have application layer
6:35
files, folders, directories, so on and
6:37
so forth. And we have our agentic layer
6:39
files. If we open up dogcloud here, do
6:41
commands, we can see we have this prime
6:44
command. As you know, the prime command
6:45
effectively represents a memory file.
6:48
But the big difference here is that you
6:50
can activate this whenever you want to
6:52
and you can fine-tune the prime command
6:54
to run any specific workflow you want
6:57
to. Okay, so this is just a prompt that
6:59
effectively activates your agent to read
7:01
specific files, right? So there's
7:03
nothing new here, right? We have a
7:04
classic agentic prompt doc of course is
7:06
our memory file that's always going to
7:08
load. You've seen this, you understand
7:09
this, you know this. And oftent times I
7:12
like to take the agents.mdia from
7:13
working with other agents and just
7:15
reference that claw.md memory file. This
7:17
is the simplest possible agentic layer.
7:19
Now in our application layer, if we're
7:21
going to user management where we have a
7:22
backend for a user management system.
7:24
This is just a starting place, right?
7:26
This is a great way to when you're
7:27
creating a new application, just start
7:29
with something an agent can come in here
7:30
and understand how to operate this right
7:32
away with the memory file and with the
7:34
prime command. Okay, so as we work
7:35
through classes and grades, we'll talk
7:37
about the compute advantage you get by
7:39
scaling to this class and grade of a
7:41
gentic layer. And then we'll of course
7:43
talk about trade-offs. So the compute
7:44
advantage here is obvious, right? We get
7:46
a clean, minimal setup. It's a great
7:48
foundation for agenda growth and agents
7:50
understand context immediately. It's a
7:52
super small code base. This is easily
7:54
reproducible by anyone. There's no value
7:56
in a codebase this small. It's useless
7:58
for large code bases. Limited capability
8:00
and there are many leverage points of
8:02
aentic coding that the class one grade 1
8:04
aentic layer purely misses. Let's scale
8:07
this up. Now we have the class one grade
8:10
two. This is where we start surrounding
8:12
our codebase with more useful leverage
8:14
points of agent coding. Here we
8:16
incorporate specialized prompts to help
8:19
us plan work. We have a prime command
8:21
and we now have access to agents also
8:24
known as sub aents. Here we can start
8:27
incrementally improving what our
8:29
codebase can do. So let's go ahead and
8:31
look at what this codebase looks like
8:32
now. Right, we have a new specs
8:34
directory where our plans are written.
8:36
You're very familiar with that pattern.
8:37
We also have AI docs so our agents can
8:39
pull in documentation to aid their
8:42
context. This is all part of the agentic
8:44
layer. And our user application is
8:45
starting to grow. We have a few tests.
8:47
We have modules. But the most important
8:49
pieces are here. In addition to our
8:51
commands, right, our raw prompts, we now
8:53
have some sub aents or just some agents
8:57
that we can run, right? So for instance,
8:58
you might have a fetch docs sub aent
9:01
that will save them in the AI docs
9:02
directory and you might have a test
9:04
writer. These are just simple examples
9:06
of starting to scale up your agentic
9:08
layer. You likely have something more
9:09
powerful than this, but we're just
9:11
working our way up. And now you might
9:13
have something like a brand new plan
9:15
file. So when you're doing work, you
9:16
might prompt this plan file and then
9:18
execute it. Very simple. We're still
9:20
just stacking things up, slowly building
9:22
up our agentic layer. This is a simple
9:24
class one grid 2 agentic layer. The big
9:27
advantages here is that we have
9:28
specialization with sub aents and we can
9:30
scale this and parallelize certain
9:33
workflows. All right. Right? And now
9:34
we're starting to collect documentation
9:35
for our agents and we're planning our
9:38
work before we implement. So this is
9:40
grade two. Many engineers have passed
9:42
this level. This is not that novel. It's
9:44
not that interesting. We're still
9:45
limited in many ways. Right? The big
9:47
thing we're missing here is custom tools
9:49
which brings us right to grade three. So
9:52
in class one, grade three things start
9:54
getting interesting and our agentic
9:55
layer starts to wrap our application
9:58
layer. So here we have three key new
10:00
pieces. skills, MCP servers, and prime
10:04
commands with tool access. You likely
10:06
already know what that is. All these
10:07
three things give us the same thing.
10:10
Custom tools that enhance our agents
10:12
core 4. Let's take a look at what this
10:14
actually looks like in an agentic layer
10:16
class one grade three. Now, we have a
10:18
couple additional base level files. You
10:20
might have a MCP.json, Postgress,
10:23
Firecrawl, Jira, Notion, whatever tool
10:25
you want to use, you can now throw it in
10:27
here. But that's not all. We know that
10:28
MCPs are very tokenheavy and we can just
10:30
prompt engineer properly to get our
10:32
agents the tools they need. One of the
10:34
ways that that can be done is with
10:36
skills. Our agents have learned to
10:38
migrate the database. And so inside of
10:40
this file, you know, you've seen these
10:41
before. We have taught our agent how to
10:43
use a specific tool and it can now use
10:46
it to perform a specific task. We're
10:48
starting to specialize our agents a
10:50
little bit more outside of our sub
10:52
agents. But we can also do things like
10:53
this, right? Start and stop application.
10:55
If we open up this skill, we are just
10:57
teaching our agent how to use scripts.
11:00
There's no need for an MCP server.
11:01
Oftent times, you can just build your
11:03
own script that exposes the right
11:04
functionality. Here we have a start and
11:06
a stop tool that starts and stops the
11:08
application. Okay, so we're just scaling
11:10
up what our agentic layer can do. We're
11:13
giving our agents more capability,
11:15
right? We are scaling our compute to
11:16
scale our impact. Our agents now have
11:18
access to custom tools, skills, and
11:21
prime commands, right? And keep in mind,
11:22
this is something that I want to keep
11:24
emphasizing. Skills and MCP servers can
11:27
both be replaced with just a simple
11:29
prompt. Okay, so we have this prime DB
11:31
with tools. You can teach your agents
11:33
how to execute CLI commands. Here we're
11:35
just using PSQL, right? So that our
11:38
agent knows how to interact with the
11:40
user management database for this mock
11:42
application. And so you can bypass
11:44
everything by just understanding how the
11:46
core 4 works, context, model, prompt,
11:48
and tools. Okay. And notice what we're
11:51
doing here, right? We're constantly
11:53
giving our agents more capability.
11:55
Custom tools is a huge step. Grade three
11:57
is very important. Now, this is when
12:00
prompt engineering and context
12:01
engineering becomes more important.
12:03
Skills, MCP servers, and prompts must
12:06
have tools carefully designed. This is
12:08
where things can start going wrong. And
12:09
a lot of engineers do get stuck at grade
12:11
three. They think they get past this,
12:13
but actually their tools are terrible
12:15
and they won't scale. And they're
12:17
chewing up tokens. They're burning cash
12:19
and they're overengineering their tools,
12:21
right? Like one of the most common
12:22
problems is that engineers will have way
12:24
too many tools. Being able to design and
12:26
give your agents the right tools via MCP
12:29
server skills and just raw prompts is a
12:33
critical skill for every agentic
12:35
engineer. Let's move on to grade four.
12:37
How do we scale this up even further?
12:39
What comes next? Right. So at this
12:41
point, we start scaling up our prompts
12:43
and we start building up feedback loops
12:46
in the codebase. Okay, so this is where
12:48
things become very powerful and where
12:50
you can really scale what you can do.
12:52
So, of course, we have our plan prompt,
12:54
but now we'll have things like our build
12:55
prompt, right? A higher order prompt.
12:57
Grade four is distinct and that you
12:59
start asking your agents to review their
13:02
work. This is where you realize that you
13:04
should always add feedback loops into
13:07
your agentic layer. You're effectively
13:09
adding more compute to get more
13:11
confidence in your agents results. All
13:13
right, this is the big idea in tactical
13:16
agentic coding. Lesson five. Right here
13:18
we're building closed loop prompts. All
13:20
right, let's understand the application
13:21
structure. So now we have things like
13:23
app review. So not only are you planning
13:25
your work, you're having your agents
13:26
review the work done and then report it.
13:29
And you're doing this with powerful
13:30
prompts like the code review prompt, the
13:32
review prompt. You're then running
13:34
reproduce bugs and then things like test
13:36
backend, test front end. All right, so
13:38
for instance, what does review do? Code
13:40
review current changes, review all stage
13:42
changes, do a bunch of stuff, and then
13:44
we're going to output some concrete
13:45
results. You might also do something
13:47
like reproduce a bug. This is where we
13:49
would save a concrete resolution file
13:52
into app reviews. This becomes really
13:54
powerful when you start giving your sub
13:57
agents these abilities. Okay, so we can
13:59
run something like a review agent and
14:01
you can scale this up and then it will
14:03
output its review into a specific file.
14:06
Inside of our application layer here,
14:08
you'll also notice something. As you
14:10
start to grow your codebase, your
14:11
agentic layer and your application layer
14:13
will be growing side by side. We've now
14:15
split out our application into client
14:17
and server. At some point, your small
14:19
codebase will grow and it will start to
14:21
fracture. This is important. We'll look
14:22
at this in the next grade. But with this
14:25
application directory structure, we're
14:27
still able to keep all related code for
14:30
this product under the same code base.
14:33
Now, how this operates in Git is
14:35
important. We'll talk about that in just
14:36
a moment. Since we have both a front end
14:38
and backend application, you can start
14:40
specializing your prompts, right? test
14:42
backend, test front end. Here we have a
14:45
concrete closed loop prompt. I'm being
14:47
really verbose here with my language
14:50
inside of these mock prompts. You know,
14:51
we're following that three-step workflow
14:53
from tactical agent to coding lesson 5.
14:56
Request, validate, resolve. This creates
14:59
a closed loop where your agent can spin
15:01
and spin until the job is done. This
15:04
distinctly marks grade four. Again, this
15:07
is a place where engineers fall off and
15:09
they miss out on using more compute to
15:11
get the job done, right? We're starting
15:13
to split our prompts to focus on
15:15
specific areas of this codebase. Okay,
15:17
so things are going from really generic
15:19
and vague, right? Plan build to more
15:22
specific, right? Test our backend, test
15:24
our front end, review with this code how
15:26
we like to do it. All right, and the
15:28
advantages here are really clear, right?
15:30
Once you start using closed loop prompts
15:32
in your codebase, your agents start
15:33
resolving their own work. You can create
15:35
specialized tasks for your front end,
15:37
for your back end, for whatever part of
15:39
your codebase, and it's all still on
15:41
this top layer. Now, we're not going to
15:43
dive into codebase organization too much
15:45
here. There are some leverage points of
15:46
agent coding that we're not going to
15:48
re-emphasize here. Here, we're focused
15:50
on giving our agents the highest
15:51
capability possible so that they are as
15:54
autonomous as possible. Now, there are
15:56
some trade-offs here. Again, things
15:58
start to get more complex. You need to
16:00
know how to prompt engineer. This is why
16:02
our agentic prompt engineering lesson
16:04
was so important. You must know how to
16:06
write these prompts properly.
16:08
Self-correcting agents is a massive
16:10
massive win for your agentic layer.
16:12
Let's move on to grade five. How does
16:13
our agentic layer continue progressing?
16:15
Now, by this point u many engineers have
16:18
many many prompts, many agents, several
16:21
skills. They've used many different
16:23
types of MCP servers and they start
16:26
scaling their work even further with a
16:29
key concept we discussed in lesson
16:31
three.
