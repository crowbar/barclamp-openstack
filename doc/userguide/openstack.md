
#Dell Cloud Solution for OpenStack&trade;  Solutions

##OpenStack Barclamps Users Guide
##Version 1.3

![OpenStack Img](https://raw.github.com/srinivasgowda/cb_doc_draft/master/pics/openstack_logo.png )

##OpenStack Version Essex


###DOCUMENT PROVIDED UNDER APACHE 2 LICENSE  
------------------------------------------------

##Notes, Cautions, and Warnings

> #####![notes.png](https://raw.github.com/srinivasgowda/cb_doc_draft/master/pics/notes.png "notes.png") A NOTE indicates important information that helps you make better use of your system.

> #####![caution.png](https://raw.github.com/srinivasgowda/cb_doc_draft/master/pics/caution.png "caution.png") A CAUTION indicates potential damage to hardware or loss of data if instructions are not followed.

> #####![warning.png](https://raw.github.com/srinivasgowda/cb_doc_draft/master/pics/warning.png "warning.png") A WARNING indicates a potential for property damage, personal injury, or death.

------------------------------------------------

###Information in this document is subject to change without notice. 

####&copy; 2011 Dell Inc. All rights reserved.

#####Reproduction of these materials is allowed under the Apache 2 license.

#####Trademarks used in this text: Dell&trade;, the DELL logo, Nagios&trade; , Ganglia&trade; , Opscode Chef&trade; , OpenStack&trade; , Canonical Ubuntu&trade; 

#####Other trademarks and trade names may be used in this publication to refer to either the entities claiming the marks and names or their products. Dell Inc. disclaims any proprietary interest in trademarks and trade names other than its own.

------------------------------------------------

# Contents 

###[Figures]

###[Tables]

###[Introduction]

####[Concepts]

####[OpenStack]

####[Dell Specific Options]

###[Architecture]

###[OpenStack Barclamp Suite]

###[Barclamps]


####[MySQL]

#####[Background]
    
#####[Barclamp Roles]


####[Keystone]

#####[Background]
    
#####[Barclamp Roles]


####[Swift ]

#####[Background]
    
#####[Barclamp Roles]


####[Glance]

#####[Background]
    
#####[Barclamp Roles]


####[Nova Dashboard - Horizon]

#####[Background]
    
#####[Barclamp Roles]


####[Nova]

#####[Background]
    
#####[Barclamp Roles]


####[Nova Volume]

####[Nova Networking]


Figures
---------------------------

1.[Crowbar Target for Openstack Deployment](#Figure-Crowbar-Target-for-Openstack-Deployment)


Tables
--------------

1.[Openstack Barclamps](#table-Openstack-Barclamps)

2.[MySQL Barclamp Parameters](#table-MySQL-Barclamp-Parameters)

3.[Keystone Barclamp Parameters](#table-Keystone-Barclamp-Parameters)

4.[Swift Barclamp Parameters](#table-Swift-Barclamp-Parameters)

5.[Glance Barclamp Parameters](#table-Glance-Barclamp-Parameters)

6.[Nova Dashboard Barclamp Parameters](#table-Nova-Dashboard-Barclamp-Parameters)

7.[Nova Barclamp Parameters](#table-Nova-Barclamp-Parameters)


[OpenStack]: 		http://openstack.org/ "Openstack"
[Crowbar]:  		https://github.com/dellcloudedge/crowbar/  "Crowbar GitHub"
[Crowbar Users Guide]: 	https://github.com/dellcloudedge/barclamp-crowbar/blob/master/crowbar_framework/public/crowbar_users_guide.pdf "Crowbar User Guide"

[OpenStack Reference Architecture (Dell Internal, RA, June 2012)]: 		http://
[Crowbar Users Guide (June 2012)]: 						http://
[Bootstrapping Open Source Clouds (Dell Tech White Paper, updated Dec 2011)]:	http://
[CloudOps White Paper (Dell Tech White Paper, Oct 2011)]: 			http://


### Introduction 
-----------------------------------
This document provides instructions to use when deploying [OpenStack][] components using [Crowbar][]1.3. This guide is for use with the [Crowbar Users Guide][], it is not a stand-alone document.

Other suggested materials:

    [OpenStack Reference Architecture (Dell Internal, RA, June 2012)][]

    [Crowbar Users Guide (June 2012)][]

    [Bootstrapping Open Source Clouds (Dell Tech White Paper, updated Dec 2011)][]

    [CloudOps White Paper (Dell Tech White Paper, Oct 2011)][]


###Concepts

The purpose of this guide is to explain the special aspects of OpenStack on Crowbar.  Please consult the Crowbar Users Guide and Crowbar Deployment Guide for assistance with installing and using Crowbar.

> #####![notes.png](https://raw.github.com/srinivasgowda/cb_doc_draft/master/pics/notes.png "notes.png") Concepts beyond the scope of this guide will be introduced as needed in notes and references to other documentation. 


###OpenStack

The focus of this guide is the use of Crowbar, not OpenStack.  While Crowbar includes substantial components to assist in the deployment of OpenStack, its operational aspects are independent of OpenStack.

> #####![openstack.png](https://raw.github.com/srinivasgowda/cb_doc_draft/master/pics/openstack.png "openstack.png") For detailed operational support for OpenStack, visit the OpenStack documentation web site [http://docs.openstack.org/](http://docs.openstack.org) 

This guide will provide additional information about OpenStack as notes flagged with the OpenStack logo.


###Dell Specific Options

The Dell End User License Agreement (EULA) version of Crowbar provides additional functionality beyond that in the open source version.  It also uses a color palette that is different from the open source version.

Crowbar is not limited to managing Dell servers and components.  Due to driver requirements, some barclamps (BIOS & RAID) must be targeted to specific hardware; however, those barclamps are not required for system configuration.

The Overview page shows an interactive reference taxonomy for an OpenStack deployment.  Crowbar highlights the sections of the taxonomy that have been enabled in the system.  Like most Crowbar pages, this page updates automatically so changes in the system status are automatically reflected.


## Architecture 
-----------------------------------
The Crowbar OpenStack deployment includes both core and incubated OpenStack components.  Crowbar deploys each component as a module, known as a barclamp.  All shared components are broken out as independent barclamps.  Crowbar automatically detects and integrates connections between barclamps as they are deployed.


> #####![openstack.png](https://raw.github.com/srinivasgowda/cb_doc_draft/master/pics/openstack.png "openstack.png") It is important to deploy the barclamps in the correct order because of the dependencies between barclamps! 
 

The figure below shows Crowbar's target OpenStack deployment with both shared and stand-alone components.  Crowbar both installs the components and integrates them together as needed.

####Figure  : Crowbar Target for Openstack Deployment
![crowbar_target_for_openstack_deployment.png](https://raw.github.com/srinivasgowda/cb_doc_draft/master/pics/crowbar_target_for_openstack_deployment.png "crowbar_target_for_openstack_deployment.png") 


### OpenStack Barclamp Suite ###
-------------------------
The Barclamps&rarr;OpenStack page shows only the barclamps that pertain to the OpenStack deployments.

The barclamps on this page are listed in deploy order from top (deploy first) to bottom (deploy last).  This ordering is intended to aid users in performing the installation in the correct order.  Not all barclamps are required; the next section explores each barclamp in detail.
 
> #####![notes.png](https://raw.github.com/srinivasgowda/cb_doc_draft/master/pics/notes.png "notes.png") Please review the barclamp use and life cycle information in the Crowbar Users Guide to learn about the status and management process for barclamps. 
 

### Barclamps 
----------------------------------
The table below shows the barclamps that are available with the Crowbar v1.3 OpenStack deployment.  

From each barclamp, you may create a new proposal for the system.

 
> #####![notes.png](https://raw.github.com/srinivasgowda/cb_doc_draft/master/pics/notes.png "notes.png") Naming for proposals is limited to letters and numbers only (not spaces).  Capitalization is allowed. 


> #####![chef.png](https://raw.github.com/srinivasgowda/cb_doc_draft/master/pics/chef.png "chef.png") This limitation is necessary because activated proposals are created as roles in Chef and follow a prescribed naming convention.
 

The following OpenStack barclamps are included with Crowbar.
<table>
<caption>Table 1: Openstack Barclamps</caption>
	<tr>
		<th>Barclamp 			</th>
  		<th>Function			</th>
  		<th>Comments			</th>
	</tr>
	<tr>
  		<td>MySQL						</td>
  		<td>Database						</td>
  		<td>Used by Keystone, Nova, Horizon, and Glance.	</td>
	</tr>
	<tr>
  		<td>Keystone						</td>
		<td>Centralized Authentication & Authorization		</td>
  		<td>Not core, but strongly recommended.When installed, 
  		the identity service is automatically leveraged by all 
		other components.					</td>
	</tr>
	<tr>
  		<td>Swift 						</td>
  		<td>Object Store					</td>
  		<td>Provides distributed object storage 		</td>
	</tr>
	<tr>
  		<td>Glance						</td>
		<td>Image Cache						</td>
  		<td>Glance service (Nova image management) for the cloud.  
		Used by Nova.						</td>
	</tr>
	<tr>
		<td>Nova Dashboard ("Horizon")				</td>
		<td>User Interface					</td>
  		<td>Not core, but strongly recommended. Provides a web 
		user interface and configuration capabilities for other 
		OpenStack components.  					</td>
	</tr>
	<tr>
  		<td>Nova						</td>
  		<td>Compute						</td>
  		<td>Supports many network modes.			</td>
	</tr>
</table>


##MySQL 
--------------------

[Crowbar MySQL GitHub]: 	https://github.com/dellcloudedge/crowbar/wiki/Mysql-barclamp "MySQL Barclamps"
[MySQL]: 			http://mysql.com "MySQL"

Please see the [Crowbar MySQL GitHub][] for the latest updates 

### Background 
[MySQL][] is a widely adopted open source database that stores relational data for several OpenStack components.  

This barclamp can support multiple proposals.

<table>
<caption>Table 2: MySQL Barclamp Parameters</caption>
	<tr>
  		<th>Name 					</th>
  		<th>Default					</th>
  		<th>Description 				</th>
	</tr>
	<tr>
  		<td>Datadir					</td>
  		<td>/var/lib/mysql				</td>
 	 	<td>Location where database files will be stored.</td>
	</tr>
</table>


### Barclamps Roles 

MySQL has two roles:  Mysql-server and Mysql-client.  The roles are used to identify which nodes are configured as servers and which are configured as clients.

Barclamps that require a MySQL client will cause a client to be automatically deployed on the appropriate nodes, and will update the MySQL proposal to reflect the nodes that have clients installed.  As a result, when creating or editing a MySQL proposal, it is only necessary to select nodes to be configured as MySQL servers by assigning them to the mysql-server role.


##Keystone 
-----------------------

[Crowbar Keystone GitHub]: 		https://github.com/dellcloudedge/crowbar/wiki/Keystone-barclamp "Keystone Barclamp"
[Keystone Identity Service]: 		http://keystone.openstack.org "OpenStack Keystone"

Please see the [Crowbar Keystone GitHub] [] for the latest updates.

### Background 
The  [Keystone Identity Service][] provides unified authentication across all OpenStack projects and integrates with existing authentication systems.

<table>
<caption>Table 3: Keystone Barclamp Parameters</caption>
	<tr>
  		<th>Name 					</th>
  		<th>Default					</th>
  		<th>Description 				</th>
	</tr>
	<tr>
  		<td>SQL Engine					</td>
  		<td>MySQL					</td>
  		<td>Choose MySQL or SQLite as a backing store	</td>
	</tr>
	<tr>
  		<td>MySQL Instance				</td>
  		<td>[generated]					</td>
  		<td>Select a MySQL proposal to use as a database
		 (requires choosing MySQL as the SQL Engine)	</td>
	</tr>
	<tr>
  		<td>Default Tenant				</td>
  		<td>openstack					</td>
  		<td>Default tenant				</td>
	</tr>
	<tr>
  		<td>Regular User Username			</td>
  		<td>crowbar					</td>
  		<td>Default user name				</td>
	</tr>
	<tr>
  		<td>Regular User Password			</td>
  		<td>crowbar					</td>
  		<td>Default user password			</td>
	</tr>
	<tr>
  		<td>Administrator Username			</td>
  		<td>admin					</td>
  		<td>Administrator user name			</td>
	</tr>
	<tr>
  		<td>Administrator Password			</td>
  		<td>crowbar					</td>
  		<td>Administrator password			</td>
	</tr>
</table>

### Barclamps Roles 
Keystone has one role: Keystone-server.  Select which server should be the Keystone server.  
The default node allocation is to use the same node as the MySQL barclamp.  This is not required.


##Swift 
----------------------

[Crowbar Swit GitHub]: 				https://github.com/dellcloudedge/crowbar/wiki/Swift--barclamp "Swift Barclamp" 
[Object Storage code named - Swift]: 		http://openstack.org/projects/storage "OpenStack Storage"

Please see [Crowbar Swit GitHub][] for the latest updates.

### Background 

OpenStack [Object Storage code named - Swift][] is open source software for creating redundant, scalable object storage using clusters of standardized servers to store petabytes of accessible data.  It is not a file system or real-time data storage system, but rather a long-term storage system for a more permanent type of static data that can be retrieved, leveraged, and then updated if necessary. Primary examples of data that best fit this type of storage model are virtual machine images, photo storage, email storage and backup archiving. Having no central "brain" or master point of control provides greater scalability, redundancy and permanence.

Objects are written to multiple hardware devices in the data center, with the OpenStack software responsible for ensuring data replication and integrity across the cluster. Storage clusters can scale horizontally by adding new nodes. All data is stored in structures called partitions, which are replicated a minimum of three times, ensuring data permanence.  Should a node fail, OpenStack works to serve its content from other active nodes and create new replicas of the objects. Because OpenStack uses software logic to ensure data replication and distribution across different devices, inexpensive commodity hard drives and servers can be used in lieu of more expensive equipment. 

The Swift barclamp includes the following components: 

* Proxy node - provides the API to the cluster, including authentication. 

* Storage nodes - provide storage for cluster. 

* Ring node - generates the ring file which is distributed to all nodes to provide the logical lookup information to determine where objects are stored in the cluster.

<table>
<caption>Table 4: Swift Barclamp Parameters	</caption>
	<tr>
  		<th>Name 							</th>
  		<th>Default							</th>
  		<th>Description 						</th>
	</tr>
	<tr>
  		<td>Keystone instance						</td>
  		<td>[generated]							</td>
  		<td>The Keystone proposal to use				</td>
	</tr>
	<tr>
  		<td>Keystone Service User					</td>
  		<td>swift							</td>
  		<td>The user that Swift uses when authenticating with Keystone	</td>
	</tr>
	<tr>
  		<td>Keystone Service Password					</td>
  		<td>[generated]							</td>
  		<td>The password for the Swift Keystone authentication user	</td>
	</tr>
	<tr>
  		<td>Zones							</td>
  		<td>2								</td>
  		<td>The number of zones in this cluster (should be >= # of 
		replicas) 							</td>
	</tr>
	<tr>
  		<td>Partitions 							</td>
  		<td>18								</td>
  		<td>The number of bits to represent the partition count 	</td>
	</tr>
	<tr>
  		<td>Minimum Partitions per Hour 				</td>
  		<td>1								</td>
  		<td>The minimum amount of time a partition should stay put, 
		in hours 							</td>
	</tr>
	<tr>
  		<td>Replicas 							</td>
  		<td>1 								</td>
  		<td>The number of replicas that should be made for each object 	</td>
	</tr>
	<tr>
  		<td>Cluster Hash 						</td>
  		<td>[generated] 						</td>
  		<td>Shared among all nodes in a swift cluster.  Can be generated
		 using od -t x8 -N 8 -A n </dev/random				</td>
	</tr>
	<tr>
  		<td>Cluster Admin Password 					</td>
  		<td>swauth 							</td>
  		<td>Super user password - used for managing users		</td>
	</tr>
	<tr>
  		<td>User 							</td>
  		<td>swift 							</td>
  		<td>The uid to be used for swift processes 			</td>
	</tr>
	<tr>
  		<td>Group 							</td>
  		<td>swift 							</td>
  		<td>The gid to be used for swift processes 			</td>
	</tr>
	<tr>
  		<td>Debug							</td>
  		<td>true							</td>
  		<td>Indicates the service should run in debug mode		</td>
	</tr>
</table>


> #####![caution.png](https://raw.github.com/srinivasgowda/cb_doc_draft/master/pics/caution.png "caution.png") For Swift, parameters should not be changed after applying the proposal.  Addition or removal of devices from the proposal will be dynamically reconfigured in the Swift configuration after the initial proposal has been applied.

### Barclamps Roles 
Swift offers three roles for configuration.  The primary role, Swift-storage, identifies the nodes that store the data.  
The infrastructure roles are Swift-ring-compute and Swift-proxy-acct.  Swift-ring-compute configures a node to provide ring file generation services, and Swift-proxy-acct provides the external access and control functions for a Swift cluster.  The default node allocation is to use the same node as the MySQL barclamp for these roles.  


##Glance 
-----------------------

[Crowbar Glance GitHub]: 		https://github.com/dellcloudedge/crowbar/wiki/Glance--barclamp "Glance Barclamp"
[Image Service code named - Glance]: 	http://openstack.org/projects/image-service "OpenStack Image Service"

Please see the [Crowbar Glance GitHub][] for the latest updates.

### Background 
OpenStack [Image Service code named - Glance][] provides discovery, registration, and delivery services for virtual disk images. The Image Service API server provides a standard REST interface for querying information about virtual disk images stored in a variety of back-end stores, including OpenStack Object Storage.  Clients can register new virtual disk images with the Image Service, query for information on publicly available disk images, and use the Image Service's client library for streaming virtual disk images.

<table>
<caption>Table 5: Glance Barclamp Parameters	</caption>
	<tr>
  		<th>Name 					</th>
  		<th>Default					</th>
  		<th>Description 				</th>
	</tr>
	<tr>
  		<td>Working Directory				</td>
  		<td>/var/lib/glance				</td>
  		<td>Glance working directory			</td>
	</tr>
	<tr>
  		<td>PID Directory				</td>
  		<td>/var/run/glance				</td>
  		<td>Location of Glance's PID files		</td>
	</tr>
	<tr>
  		<td>Notifier Strategy				</td>
  		<td>Noop					</td>
  		<td>The only option is "No Operation"		</td>
	</tr>
	<tr>
  		<td>Image Store Directory			</td>
  		<td>/var/lib/glance/images			</td>
  		<td>Location of images				</td>
	</tr>
	<tr>
  		<td><b>Scrubber:				</td>
  		<th colspan="2">				</th>
  	</tr>
	<tr>
  		<td>Log File					</td>
  		<td>/var/log/glance/scrubber.log		</td>
  		<td>The location where the scrubber will log	</td>
	</tr>
	<tr>
  		<td>Config File					</td>
  		<td>/etc/glance/glance-scrubber.conf		</td>
  		<td>The configuration file for the scrubber	</td>
	</tr>
	<tr>
  		<td>Debug					</td>
  		<td>false					</td>
  		<td>Indicates if the scrubber will run in debug mode</td>
	</tr>
	<tr>
  		<td>Verbose					</td>
  		<td>true					</td>
  		<td>Indicates if the scrubber will run in verbose mode</td>
	</tr>
	<tr>
  		<td><b>Reaper:					</td>
  		<th colspan="2">				</th>
  	</tr>
	<tr>
  		<td>Log File					</td>
  		<td>/var/log/glance/reaper.log			</td>
  		<td>The location where the reaper will log	</td>
	</tr>
	<tr>
  		<td>Config File					</td>
  		<td>/etc/glance/glance-reaper.conf		</td>
  		<td>The configuration file for the reaper	</td>
	</tr>
	<tr>
  		<td>Debug					</td>
  		<td>false					</td>
  		<td>Indicates if the reaper will run in debug mode</td>
	</tr>
	<tr>
  		<td>Verbose					</td>
  		<td>true					</td>
  		<td>Indicates if the reaper will run in verbose mode</td>
	</tr>
	<tr>
  		<td><b>Pruner:					</td>
  		<th colspan="2">				</th>
 	</tr>
	<tr>
  		<td>Log File					</td>
  		<td>/var/log/glance/pruner.log			</td>
  		<td>The location where the pruner will log	</td>
	</tr>
	<tr>
  		<td>Config File					</td>
  		<td>/etc/glance/glance-pruner.conf		</td>
  		<td>The configuration file for the pruner	</td>
	</tr>
	<tr>
  		<td>Debug						</td>
  		<td>false						</td>
  		<td>Indicates if the pruner will run in debug mode	</td>
	</tr>
	<tr>
  		<td>Verbose						</td>
  		<td>true						</td>
  		<td>Indicates if the pruner will run in verbose mode	</td>
	</tr>
	<tr>
  		<td><b>Prefetcher:					</td>
  		<th colspan="2">					</th>
  	</tr>
	<tr>
  		<td>Log File						</td>
  		<td>/var/log/glance/prefetcher.log			</td>
  		<td>The location where the prefetcher will log		</td>
	</tr>
	<tr>
  		<td>Config File						</td>
  		<td>/etc/glance/glance- prefetcher.conf			</td>
  		<td>The configuration file for the prefetcher		</td>
	</tr>
	<tr>
  		<td>Debug						</td>
  		<td>false						</td>
  		<td>Indicates if the prefetcher will run in debug mode	</td>
	</tr>
	<tr>
  		<td>Verbose						</td>
  		<td>true						</td>
  		<td>Indicates if the prefetcher will run in verbose mode</td>
	</tr>
	<tr>
  		<td><b>API:						</td>
 	 	<th colspan="2">					</th>
 	</tr>
	<tr>
  		<td>Log File						</td>
  		<td>/var/log/glance/api.log				</td>
  		<td>The location where the API will log			</td>
	</tr>
	<tr>
  		<td>Config File						</td>
  		<td>/etc/glance/glance-api.conf				</td>
  		<td>The configuration file for the API			</td>
	</tr>
	<tr>
  		<td>Paste INI File					</td>
  		<td>/etc/glance/glance-api-paste.ini			</td>
  		<td>Paste Deploy configuration file for the API		</td>
	</tr>
	<tr>
  		<td>Debug						</td>
  		<td>false						</td>
  		<td>Indicates if the API will run in debug mode		</td>
	</tr>
	<tr>
  		<td>Verbose						</td>
  		<td>true						</td>
 	 	<td>Indicates if the API will run in verbose mode	</td>
	</tr>
	<tr>
  		<td>Bind to All Addresses				</td>
  		<td>true						</td>
  		<td>Controls if the API will bind to all addresses or 
		the public address only					</td>
	</tr>
	<tr>
  		<td>Access Port						</td>
  		<td>9292						</td>
  		<td>The port the API service will run on		</td>
	</tr>
	<tr>
  		<td><b>Registry:					</td>
  		<th colspan="2">					</th>
  	</tr>
	<tr>
  		<td>Log File						</td>
  		<td>/var/log/glance/registry.log			</td>
  		<td>The location where the registry will log		</td>
	</tr>
	<tr>
  		<td>Config File						</td>
  		<td>/etc/glance/glance-registry.conf			</td>
  		<td>The configuration file for the registry		</td>
	</tr>
	<tr>
  		<td>Paste INI File					</td>
  		<td>/etc/glance/glance-registry-paste.ini		</td>
  		<td>Paste Deploy configuration file for the registry	</td>
	</tr>
	<tr>
  		<td>Debug						</td>
  		<td>false						</td>
  		<td>Indicates if the registry will run in debug mode	</td>
	</tr>
	<tr>
  		<td>Verbose						</td>
  		<td>true						</td>
  		<td>Indicates if the registry will run in verbose mode	</td>
	</tr>
	<tr>
  		<td>Bind to All Addresses				</td>
  		<td>true						</td>
  		<td>Controls if the registry will bind to all addresses 
		or the public address only				</td>
	</tr>
	<tr>
  		<td>Access Port						</td>
  		<td>9191						</td>
  		<td>The port the registry service will run on		</td>
	</tr>
	<tr>
  		<td><b>Caching:						</td>
  		<th colspan="2">					</th>
  	</tr>
	<tr>
  		<td>Enable Caching 					</td>
  		<td>false						</td>
  		<td>Indicates if caching should be on			</td>
	</tr>
	<tr>
  		<td>Turn On Cache Management				</td>
  		<td>false						</td>
  		<td>Enables the use of glance-cache-manage CLI & the 
		corresponding API					</td>
	</tr>
	<tr>
  		<td>Directory						</td>
  		<td>/var/lib/glance/image-cache				</td>
  		<td>The location where images are cached		</td>
	</tr>
	<tr>
  		<td>Grace Period					</td>
  		<td>3600						</td>
  		<td>The timeout for accessing the image			</td>
	</tr>
	<tr>
  		<td>Stall Timeout					</td>
  		<td>86400						</td>
  		<td>The timeout to wait for a stalled GET request	</td>
	</tr>
	<tr>
  		<td><b>Database:					</td>
  		<th colspan="2">					</th>
 	</tr>
	<tr>
  		<td>Database Type					</td>
  		<td>MySQL						</td>
  		<td>Type of database (MySQL or SQLite)			</td>
	</tr>
	<tr>
  		<td>SQL Idle Timeout					</td>
  		<td>3600						</td>
  		<td>MySQL idle time check				</td>
	</tr>
	<tr>
  		<td>SQLite Connection String				</td>
  		<td>  							</td>
  		<td>String for SQLite connection.  Only used if not 
		using MySQL						</td>
	</tr>
	<tr>
  		<td>MySQL Instance					</td>
  		<td>[generated]						</td>
  		<td>The Crowbar MySQL proposal to use			</td>
	</tr>
	<tr>
  		<td>Use Keystone					</td>
  		<td>True</td>
  		<td>Indicates to Crowbar if Keystone is to be used 
		for authentication					</td>
	</tr>
	<tr>
  		<td>Keystone Instance					</td>
  		<td>[generated]						</td>
  		<td>The Crowbar Keystone proposal to use		</td>
	</tr>
	<tr>
  		<td>Service User					</td>
  		<td>glance						</td>
  		<td>The user that Glance uses when authenticating with 
		Keystone						</td>
	</tr>
	<tr>
  		<td>Service Password					</td>
  		<td>[generated]						</td>
  		<td>The password for the Swift Keystone authentication
		 user							</td>
	</tr>
	<tr>
  		<td>Use Syslog						</td>
  		<td>False						</td>
  		<td>Indicates to Glance to not log to syslog		</td>
	</tr>
</table>

### Barclamps Roles 
Glance provides the glance-server role so that users can select a node as the glance server.  This node should have adequate disk space to cache images.  The default node allocation is to use the same node as the MySQL barclamp.  This is not required.


##Nova Dashboard (''Horizon'')
-----------------------------------------------

[Crowbar Nova Dashboard GitHub ]: 	https://github.com/dellcloudedge/crowbar/wiki/Nova-dashboard-barclamp "Horizon Barclamp"
[Dashboard]: 				http://www.openstack.org/software/openstack-dashboard/  "OpenStack Dashboard" 

Please see [Crowbar Nova Dashboard GitHub][] for the latest updates.

### Background 
OpenStack [Dashboard][] enables administrators and users to access and provision cloud-based resources through a self-service portal.

<table>
<caption>Table 6: Nova Dashboard Barclamp Parameters</caption>
	<tr>
  		<th>Name 					</th>
  		<th>Default				</th>
  		<th>Description 				</th>
	</tr>
	<tr>
  		<td>SQL Engine				</td>
 		<td>MySQL					</td>
  		<td>Choose database type (MySQL or SQLite)	</td>
	</tr>
	<tr>
  		<td>MySQL Instance				</td>
  		<td>[generated]				</td>
  		<td>Select the Crowbar MySQL proposal to use	</td>
	</tr>
	<tr>
  		<td>Keystone Instance			</td>
  		<td>[generated]				</td>
  		<td>Select the Crowbar Keystone proposal to use	</td>
	</tr>
</table>

<a id="Horizon-Barclamps-Roles"/>
### Barclamps Roles 
Dashboard provides the Nova-dashboard-server role so that users can select a node as the dashboard server.  The default node allocation is to use the same node as the MySQL barclamp.  This is not required.



<a id="Nova"/>
##Nova 
----------------------

[Crowbar Nova GitHub]: 			https://github.com/dellcloudedge/crowbar/wiki/Nova--barclamp "Nova Crowbar" 
[OpenStack Compute]: 			http://openstack.org/projects/compute/ "OpenStack Compute"

Please see [Crowbar Nova GitHub][]  for the latest updates.

<a id="Nova-Background"/>
### Background 
from 
[OpenStack Compute][] is open source software designed to provision and manage large networks of virtual machines, creating a redundant and scalable cloud computing platform.  It gives you the software, control panels, and APIs required to orchestrate a cloud, including running instances, managing networks, and controlling access through users and projects. OpenStack Compute strives to be both hardware and hypervisor agnostic, currently supporting a variety of standard hardware configurations and seven major hypervisors.

<table>
<caption>Table 7: Nova Barclamp Parameters</caption>
	<tr>
  		<th>Name 					</th>
  		<th>Default				</th>
  		<th>Description 				</th>
	</tr>
	<tr>
  		<td>MySQL					</td>
  		<td>[generated]				</td>
  		<td>The MySQL proposal to use			</td>
	</tr>
	<tr>
  		<td>Keystone				</td>
  		<td>[generated]				</td>
  		<td>The Keystone proposal to use		</td>
	</tr>
	<tr>
  		<td>Keystone Service User			</td>
  		<td>nova					</td>
  		<td>The user that Nova uses when authenticating
		 with Keystone				</td>
	</tr>
	<tr>
  		<td>Keystone Service Password			</td>
  		<td>[generated]				</td>
  		<td>The password for the Nova Keystone
		 authentication user			</td>
	</tr>
	<tr>
  		<td>Glance				</td>
  		<td>[generated]				</td>
  		<td>The Glance proposal to use		</td>
	</tr>
	<tr>
  		<td>Verbose				</td>
  		<td>true					</td>
  		<td>Indicates if Nova will run in verbose mode	</td>
	</tr>
	<tr>
  		<td>Use NoVNC (otherwise VPN-VNC)		</td>
  		<td>true					</td>
  		<td>Indicates what VNC package to use		</td>
	</tr>
	<tr>
  		<td>Hypervisor				</td>
  		<td>kvm					</td>
  		<td>Indicates what hypervisor Nova should use
		 when spinning up virtual machines (select qemu
		 if running Nova on virtual machines).  The
		 default is kvm, but will be switched to qemu if
		 virtual machines are detected.		</td>
	</tr>
	<tr>
  		<td><b>Network Options:			</td>
  		<th colspan="2">				</th>
	</tr>
	<tr>
  		<td>Use Tenant Vlans			</td>
  		<td>false					</td>
  		<td>Indicates if Nova should use VLANs for each
		 tenant					</td>
	</tr>
	<tr>
  		<td>DHCP Enabled				</td>
  		<td>true					</td>
  		<td>Indicates if Nova should hand out IP addresses
		 using DHCP				</td>
	</tr>
	<tr>
  		<td>High Availability Enabled			</td>
  		<td>true					</td>
  		<td>Indicates if Nova should use HA networking
		 mode					</td>
	</tr>
	<tr>
  		<td>Allow Same-Network Traffic		</td>
  		<td>false					</td>
  		<td>Network security option that isolates VMs from
		 same network traffic			</td>
	</tr>
	<tr>
  		<td>Number of Networks			</td>
  		<td>1					</td>
  		<td>The number of subnets to split the nova-fixed
		 network into from the network barclamp.  Used for
		 VLAN mode				</td>
	</tr>
	<tr>
  		<td>Network Size				</td>
  		<td>256					</td>
  		<td>The number of IP addresses in a single network.
		  Used for VLAN mode			</td>
	</tr>
	<tr>
  		<td><b>Volume Options:			</td>
  		<th colspan="2">				</th>
  
	</tr>
	<tr>
  		<td>Name of Volume				</td>
  		<td>nova-volumes				</td>
  		<td>The name of the volume-group created on the
		 nova-volume node				</td>
	</tr>
	<tr>
  		<td>Type of Volume				</td>
  		<td>Raw</td>
  		<td>This field indicates the type of volume to 
		create. If raw is specified, the system attempts
		to use the remaining unused disks to create a
		 volume group.  If the system doesn't have
		 additional free drives, the system will switch to
		 local.  Local uses a local file in the existing
		 file system based upon other parameters.	</td>
	</tr>
	<tr>
  		<td>Volume File Name			</td>
  		<td>/var/lib/nova/volume.raw			</td>
  		<td>When local type is chosen or fallen back to,
		 this field is the name of the file in the file
		 system to use				</td>
	</tr>
	<tr>
  		<td>Maximum File Size			</td>
  		<td>2000					</td>
  		<td>This parameter is specified in gigabytes.
		 When local type is chosen or fallen back to, this
		 field defines the maximum size of that file.  If
		 the file is too big for the file system, the size
		 of the file will be capped to 90% of the free
		 space in that file system (at the time of
		 creation)				</td>
	</tr>
	<tr>
  		<td>Disk selection method			</td>
  		<td>all					</td>
  		<td>When raw type is chosen, this field indicates
		 how to select the disks to use for volume
		 construction.  "all" means use all available. 
		 "first" means use the first one detected. 
		 "selected" means use the disks selected in the
		 list below this option.			</td>
	</tr>
</table>

### Barclamps Roles 
The Nova barclamp has three roles.  The Nova-multi-controller role determines which node(s) perform the infrastructure management and API functions.  The default node allocation for the controller role is to use the same node as the MySQL barclamp.  This is not required.

The Nova-multi-compute role identifies nodes that act as virtualization hosts.  The majority of the nodes in the nova deployment will perform this role. 

The Nova-multi-volume role identifies a single node on which a Nova volume will be created.  The default node allocation for the volume role is to use the same node as the controller role.


###Nova Volume
---------------------------
For Essex, the OpenStack dashboard requires a nova-volume service to function and display properly.  Crowbar's Nova barclamp has been updated to have a new Nova-multi-volume role.  A node with the Nova-multi-volume role will be deployed with a RAID10 configuration to enable redundancy for the volume store.  The volume is created when the Nova proposal is applied.  Changing Nova-multi-volume parameters after initial application may not work correctly.  At the present time, Nova volumes are not cleaned up or removed.

After both the Nova and Nova Dashboard proposals have been applied, the OpenStack Dashboard can be used to create, attach, detach, and destroy volumes.  The "Instances & Volumes'' tab of the navigation column allows for manipulation of volumes.  Volumes can be snapshotted and should be visible in the "Images & Snapshots" tab.   Attached volumes can be validated by logging in to the VM and running "fdisk -l".

Note that at the present time, volumes cannot be attached for VMs in systems using the qemu hypervisor.



##Nova Networking
----------------------

[Crowbar wiki]: https://github.com/dellcloudedge/crowbar/wiki/Network--barclamp "Network Barclamp"

This section is called out separately because of its complexity and scope.  It is not a complete reference.  Please refer to the [Crowbar wiki][] for complete networking details.

Nova has three networking modes available. They are integrated with the networking barclamp modes.  Initially, the nova modes will be described and then the integration with the networking barclamp will be described.  While the three modes are different, they use a consistent underlying networking mode. 

The Nova barclamp assumes that the Networking barclamp is running and handling the networks.  It uses the information about the network topology from the networking barclamp.  Nova assumes that three networks are available:  admin, public, and nova_fixed_network.  The nova_floating_network is defined, but not used or required.  The usage of this network is evolving in the community.  The admin network is used for service communication.  The public network is used for the outward facing public services of Nova.  nova_fixed_network is used for the VMs.  It is assumed that nova_fixed_network is a completely owned subnet.  The public network may be partially presented.  In all cases, the nova-network node will act as the router between public and nova_fixed_network.  Note that in a standard Crowbar Nova deployment, the nova-network node is the same as the Nova-multi-controller node.


##Flat Network 
---------------------------

In this mode, the nova-compute node gets an address from nova-network and injects that address into the VM's image (linux-only).  In our setup, this image then pulls from the node with the nova-api role to get its custom configuration files (keys, etc).
 
The nova-network node acts as the router between the public facing networks. This is NOT part of normal Nova Flat Network.  It is part of Nova for the other modes. 

For the flat network, the network parameters should be configured to separate the nova_fixed_network into a single network with all addresses available.  This is specified in the "Number of Networks" and "Network Size" parameters.  The DHCP start/end parameters of the nova_fixed network act as a reservation section of addresses for that range.  This allows users to remove shared network pieces.
 
This mode will use the interfaces specified by the network barclamp.  By default, it will use eth0.500 for the nova_fixed network, eth0.300 for the public network, and eth0 for admin.  Bridges will be created as appropriate.  If the network mode is changed in the network barclamp, it will switch to using the teamed network or dual NIC for the fixed and public networks.


##Flat DHCP Network 
------------------------------
In this mode, the nova-compute node doesn't modify the VM image or allocate an address.  The VM is assumed to run DHCP to get its address, and then talk to the nova-api for custom configuration.  The nova-network node runs dnsmasq to provide DHCP to the nova_fixed_network. 

The network parameters should be configured to separate the nova_fixed_network into a single network with all addresses available.  This is specified in the "Number of Networks" and "Network Size" parameters.  The DHCP start parameter of the nova_fixed_network acts as the DHCP starting address for the nova-network agent. 

This mode will use the interfaces specified by the network barclamp.  By default, it will use eth0.500 for the nova_fixed network, eth0.300 for the public network, and eth0 for the admin network.  Bridges will be created as appropriate.  If the network mode is changed in the network barclamp, it will switch to using the teamed network or dual NIC for the fixed and public networks. 


##VLAN DHCP Network 
------------------------------
In this mode, the nova-compute node doesn't modify the VM image and uses dnsmasq to hand out addresses.  There are two important differences between this mode and Flat DHCP mode.  First, a custom VLAN is allocated for each project. The project gets the next free VLAN after the nova_fixed network VLAN, and each project gets a subset of the nova_fixed network VLAN defined by the "Number of Networks" and "Network Size" parameters.  If the nova_fixed network is a class B,  "Number of Networks" is 1024, and "Network Size" is 64, then this will support 1024 projects.  The external assumptions are that the networking barclamp has setup the single, dual or teamed network, and that the reserved VLANs are already trunked by the switch.  Default switch configs already trunk all VLANs to all ports. 

This mode will use the interfaces specified by the network barclamp. By default, it will use eth0.500 for the nova_fixed network, eth0.300 for the public network, and eth0 for the admin network.  Bridges will be created as appropriate.  If the network mode is changed in the network barclamp, it will switch to using the teamed network or dual NIC for the fixed and public networks.  Custom VLANs that are allocated to each project will start at 501 and continue upwards. 

The second important difference is the introduction of a VPN VM that is managed by nova-network to provide access to the network.  The nova-network node acts as a router/firewall for the network and routes to the VPN to allow access to the VMs.  The VM is controlled and managed by nova-network.  It is often called a cloud-pipe.  The cloud-pipe image needs to be in Glance and setup in a way that openvpn configuration can be injected into it. 

-------------------------------------------





