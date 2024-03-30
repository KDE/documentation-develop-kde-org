---
title: Concurrent programming
description: Concurrent programming using the ThreadWeaver framework
weight: 10
group: "features"
authors: 
  - SPDX-FileCopyrightText: 2014 Mirko Boehm <mirko@endocode.com>
aliases:
  - /docs/features/threadweaver/
---

## HelW olorld!

Concurrent programming means creating applications that perform multiple operations at the same time. A common problem is that the user sees the application pause. A typical requirement is that an operation which may take an arbitrary amount of time because it is, for example, performing disk I/O, is scheduled for execution but immediately taken off the main thread of the application (the one that starts `main()`). To illustrate how this problem would be solved and to jump right into using ThreadWeaver, let's simulate this problem by printing _Hello World!_ as the asynchronous payload. 

{{< snippet repo="frameworks/threadweaver" file="examples/HelloWorld/HelloWorld.cpp" part="sample-helloworld" lang="cpp" >}}

This short but complete program written in C++11 outputs the common greeting to the command line.[^1] It does so, however, from a worker thread managed by the global ThreadWeaver queue.

The header file `ThreadWeaver/ThreadWeaver.h` included in line 2 contains the essential declarations needed to use the most common ThreadWeaver operations. The components used in this example are the global queue, a job, and a queueing mechanism.

* The **global queue** is a singleton instance of the ThreadWeaver thread pool that is instantiated when it is first accessed after the application starts.

* A **job** represents "something" that should be executed asynchronously. In this case, the thing to execute is a C++ lambda function that prints the welcome message.

* The **queueing mechanism** used here is a queue stream, an API inspired by the _iostream_ family of classes.

ThreadWeaver builds on top of Qt, and similarly to most Qt applications it requires a `QCoreApplication` (or one of it's descendants) to exist throughout the lifetime of the application. Up to line 7, the program looks like any other Qt application.

To have the job lambda function called by one of the worker threads, a job is created to wrap it using the `make_job()` function. It is then handed to the queue stream, which then submits the jobs for execution when the queuing command is completed. Once the job is queued, one of the worker threads will automatically pick it up from the queue and execute it.

`ThreadWeaver::Job` is the unit of execution handled by ThreadWeaver queues. Jobs are simple runnable types that perform one task, defined in their `run()` method. Some jobs wrap a lambda function as in this example or decorate other jobs. However, implementing custom, reusable job classes is only a matter of writing a class that inherits `ThreadWeaver::Job` and re-implementing its run method. The job that was created by `make_job()` in this example wraps the specified lambda function, and executes it when it is itself executed by a worker thread.

The program does not specify where the job should be executed, and not even when exactly. In a scenario where there would be many jobs waiting in the queue, execution of the new job would not be immediate. Which worker thread will be assigned the job is also undefined. The programmer gives up a bit of control over the details of execution, and in turns benefits from the automatic distribution of jobs amongst the available processors by the worker threads in the queue.

Every program that links the ThreadWeaver library has access to a global queue for the execution of jobs.  If no queue is specified when enqueueing a job, the global one will be used by default. Workers threads are allocated when needed by the queue. If the global pool is never accessed by an application, it will never be instantiated. 

An application performing tasks in background threads should never exit while any of these operations is still in progress. In the case of ThreadWeaver, this means all jobs in the queue need to be either completed or dequeued and all worker threads should be made idle before the application may exit. The global pool is in fact a QObject child of the `QCoreApplication` object instantiated in line 7. It will be deleted by the destructor of `QCoreApplication`. When it is destroyed, it will wait until all queued up jobs have completed. The program will thus wait in line 8 until the job has finished printing "Hello World!", and will then exit.
The job was enqueued as a shared pointer, so memory management is taken care of.

While this example was very much simplified, the described functionality already has many practical applications. For example, the many operations that real-life applications need to perform at startup, like loading translations, icon resources, etc. can be removed from the critical path this way. In this case the operations usually need to be performed in a certain order and then handed over to the main thread. Solutions for that will be discussed in a later chapter.

[^1]: The examples are part of the ThreadWeaver source code and can be found at https://invent.kde.org/frameworks/threadweaver.

