# COMP4651 Exercise-1

## HDFS APIs

In this exercise, you will write a simple code that copies a file from HDFS to the local disk, using HDFS APIs. Please follow these instructions carefully!

On the EC2 instance, clone this repo. In particular, you may create a directory called `comp4651` in the home folder: `mkdir comp4651`. You can `cd` into that directory and then `git clone` the exercise repo, which will download the sample and skeleton code to your EC2 instance. Since we mounted the directory into docker via `docker run -v`, we can access this directory inside the container.

For easy development, we need to use VSCode as our primary remote text editor. Please refer to Lab-0 for how to set up VSCode for server.

This exercise repo is generated using [Apache Maven][Maven], a software project management and comprehension tool. If you examine the structure of the repo using `tree exercise-1`, you'll find a `pom.xml` file in the root directory (which tells [Maven][Maven] how to build the code) and a source folder `src/`. Inside `src/`, there are two sub-directories, one for the main source code (`main/`) and another for the test code (`test/`). The test code is nothing but a place holder and will not be used in this assignment. The "meat" locates in the source folder, where you'll find three Java class files: `CopyFile.java` (which copies a file in a specified filesystem to another), `CopyLocalFile.java` (which copies a local file to HDFS), and `FileSystemCat.java` (which prints out the file contents). The latter two are complete example code that are well documented, while `CopyFile.java` is just a *skeleton* that has not been implemented.

**Your job is to complete the skeleton** `CopyFile.java` **with which your can copy a file from HDFS to a local disk.**

To try out the sample code, let's `cd` into the `exercise-1` folder under which `pom.xml` is located. You can now build the Maven project and package it to a jar file with the following command:
```
mvn clean package --settings settings.xml
```
Once the build succeeds, you should be able to run the two samples. Let's first copy a local file to HDFS:
```
hadoop jar target/assignment-1-1.0-SNAPSHOT.jar hk.ust.comp4651.CopyLocalFile hkust.txt hkust.txt
```
You will find a copy of `hkust.txt` file in HDFS:
```
hadoop fs -ls
```
You can now print out the contents of this file in HDFS:
```
hadoop jar target/assignment-1-1.0-SNAPSHOT.jar hk.ust.comp4651.FileSystemCat hkust.txt
```
The output should match the local copy: `cat hkust.txt`.

Now it's time to examine the two example code in details and complete your `CopyFile.java`. After you are done, you can build the Maven project with `mvn clean package` and do some tests. For example, you can copy back `hkust.txt` from HDFS to the local disk:
```
export LOCAL_DIR=file:///`pwd`
hadoop jar target/assignment-2-1.0-SNAPSHOT.jar hk.ust.comp4651.CopyFile hkust.txt $LOCAL_DIR/cp-hkust.txt
```
> In [QuickStarts VM][QuickStarts], the default filesystem is HDFS. If your want to refer to a local filesystem, you need to specify a prefix `file:///` before a file path.

If your implementation is correct, you will find a `cp-hkust.txt` file in your current directory, with the same contents as `hkust.txt`. You can try to copy other files for further tests.


### Self Testing

To self-test your code, you need to build your Maven artifact:
```
mvn clean package --settings settings.xml
```
You can then generate a random dummy file, say 100 MB, and calculate its md5sum:
```
head -c 100M < /dev/urandom > dummy
md5sum dummy > md5.txt
```
You shall then move the dummy file to HDFS and copy it back using your code:
```
hadoop jar target/assignment-2-1.0-SNAPSHOT.jar hk.ust.comp4651.CopyFile dummy $LOCAL_DIR/dummy
```
Finally, you could calculate the md5sum of the file and check if it matches that of the original copy:
```
md5sum -c md5.txt
```

[QuickStarts]: https://downloads.cloudera.com/demo_vm/virtualbox/cloudera-quickstart-vm-5.13.0-0-virtualbox.zip
[VMWare VM]: https://downloads.cloudera.com/demo_vm/vmware/cloudera-quickstart-vm-5.13.0-0-vmware.zip
[KVM VM]: https://downloads.cloudera.com/demo_vm/kvm/cloudera-quickstart-vm-5.13.0-0-kvm.zip
[Docker Image]: https://hub.docker.com/r/comp4651/quickstart
[Maven]: https://maven.apache.org
[Eclipse]: https://eclipse.org
[IntelliJ]: https://www.jetbrains.com/idea/
