RMASBench: Multi-Agent Coordination Benchmark
=============================================

This is the main repository of the RMASBench benchmarking tool. There's actually no code in this repository, but it contains git submodules of all necessary software to run the platform and all available algorithms.

Requirements
------------

All software in the RSLBench platform is written in *java 1.7*. Hence, to compile and run it you need to have *java 1.7* installed and set as your default java platform. You can check your java version by running `java -version` in a terminal. You also need both maven and ant installed in your system to compile the different libraries.

The software is known to work in both *Mac OS X 10.7* with the *Oracle JDK*, and *Ubuntu GNU/linux* with *OpenJDK*. Unfortunately, no version of windows is supported at this time.

Installation
------------

Check out this repository and all its submodules to your computer:

	git clone --recursive https://github.com/RMASBench/RMASBench.git

You will get an RMASBench folder containing 4 sub-folders (projects):

- **BinaryMaxSum.** 
	Library that implements a binary version of MaxSum, including special factors whose messages can be computed more efficiently.

- **Maxsum.**
	Library that implements the standard version of MaxSum.

- **RSLB2.**
	Main tool of the RMASBench platform. This is where most of your work and test will take place, as it allows for an easy interfacing with the robocup rescue simulation platform.

- **roborescue**
	Robocup Rescue agent simulation platform.

All this software must be compiled before being able to run the *RSLB2* tool. This can be easily achieved by using ant with the proper target for each subfolder:

	cd BinaryMaxSum; mvn package; cd ..
	cd MaxSum; ant jar; cd ..
	cd roborescue; ant oldsims jars; cd ..
	cd BlockadeLoader; ant jar; cd ..
	cd RSLB2; ant jar; cd ..

If everything compiles well (you can ignore warnings), you are now ready to start testing. 


Usage
-----

Normally, you will run experiments from within the *RSLB2/boot* folder. Get into that folder and check out the launcher's options:

	cd RSLB2/boot
	./start.sh -h

You can now launch an example scenario using any of the included algorithms. When testing, include the "*-v*" flag to enable the simulation viewer. For example, you can run the example scenario with agents coordinated by the MaxSum algorithm:

	./start.sh -v -a MaxSum

**Warning:** The first time you run a scenario of a map (default is "paris"), the simulator will pre-compute a number of things about the map. This process takes a lot of time, during which the program may seem to freeze. If you want to see the process, open a new terminal, move to the *RSLB2/boot* folder and execute:

	tail -f logs/*/fire.log

Developing your coordination algorithm in RMASBench
---------------------------------------------

You can develop your coordination algorithm in RMASBench by using the coordination API.
This [pdf](https://github.com/RMASBench/RSLB2/raw/master/docs/rmas_benchmark.pdf) document provides info on how to do this.



Resources
--------

* [AAMAS 2013 Video](https://www.youtube.com/watch?v=39y6tkhv5O4)
* [AAMAS 2013 Short Paper](http://www.ifaamas.org/Proceedings/aamas2013/docs/p1195.pdf)
