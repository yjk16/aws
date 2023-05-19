# AWS S3

### To connect via terminal:

In terminal:

`aws configure`

Make sure you're in the correct directory:

Enter your `AWS Access Key ID`

Enter your `AWS Secret Access key`

Enter `eu-west-1`

Enter `json`

Then `aws s3 ls` to see a list of s3s

You are now connected.

----

### To make a bucket in the terminal

`aws s3 mb s3://<tech230-yoonji-bucket> --region eu-west-1`
where <> = name of bucket

----

### To copy a bucket in the terminal

`aws s3 cp sampletext.txt s3://tech230-yoonji-bucket`
Here 'sampletext.txt' is the name of the file and 'tech230-yoonji-bucket' is the name of the bucket.

To check, go to your AWS console and click on your bucket.  Your text file should be there.

----

### To read a bucket in the terminal

`aws s3 sync s3://tech230-yoonji-bucket s3_downloads`
where 'tech230-yoonji-bucket' is the name of the bucket

----

### To delete a bucket in the terminal

You can't delete a bucket that has something in it.  You have to empty it first.

`aws s3 rm s3://tech230-yoonji-bucket/sampletext.txt` to remove it first, then

`aws s3 rb s3:// tech230-yoonji-bucket` to remove everything.

`aws s3 rm s3://tech230-yoonji-bucket --recursive` to delete everything

----

### To CRUD in Python using boto3git

### To access s3

`import boto3`

`s3 = boto3.resource("s3")`

`for bucket in s3.buckets.all():`
    `print(bucket.name)`

----

### To upload to bucket

`import boto3`

`s3 = boto3.resource("s3")`

`data = open("sampletext.txt", "rb")`

`s3.Bucket("tech230-yoonji-boto").put_object(Key="sampletext.txt", Body=data)`

----

### To download from bucket

`import boto3`

`s3 = boto3.client("s3")`

Where the arguments are ("name of bucket", "name of file being copied", "name of file once copied")
`s3.download_file("tech230-yoonji-boto", "sampletext.txt", "sampletext1.txt")`

`print(s3)`

----

### To delete from bucket

`import boto3`

`s3 = boto3.resource("s3")`

Where the arguments are ("name of bucket", "name of file"):
`s3.Object("tech230-yoonji-boto", "sampletext.txt").delete()`