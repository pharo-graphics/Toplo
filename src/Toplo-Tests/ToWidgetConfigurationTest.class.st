"
A ToWidgetConfigurationTest is a test class for testing the behavior of ToWidgetConfiguration
"
Class {
	#name : #ToWidgetConfigurationTest,
	#superclass : #TestCase,
	#instVars : [
		'element'
	],
	#category : #'Toplo-Tests-Core-Configuration'
}

{ #category : #running }
ToWidgetConfigurationTest >> setUp [ 

	super setUp.
	element := ToBlElementForConfigurationTest new
]

{ #category : #tests }
ToWidgetConfigurationTest >> testElementAddedInSpace [

	| space |
	space := BlSpace new.
	space root addChild: element.
	self assert: element configurationCount equals: 1.
	space root checkConfigurationPassDeeplyInSpace: space.
	" the configuration should not be runned again "
	self assert: element configurationCount equals: 1.


	
]

{ #category : #tests }
ToWidgetConfigurationTest >> testElementApplyConfigurationProgrammaticallyAfterInSpace [
	" 
	There is no useless configuration application if #requestConfiguration is not sent "

	| space |
	space := BlSpace new.
	space root addChild: element.
	element checkConfigurationPassDeeplyInSpace: space.
	self assert: element configurationCount equals: 1.
	space root checkConfigurationPassDeeplyInSpace: space.
	" the configuration should not be runned again "
	self assert: element configurationCount equals: 1
]

{ #category : #tests }
ToWidgetConfigurationTest >> testElementApplyConfigurationProgrammaticallyBeforeInSpace [
	" show that one should avoid as much as possible to send #applyConfiguration 
	programmatically to avoid useless multiple configuration applications.
	
	Notice that sending #applyConfiguration is allowed and can be necessary in some cases"

	| space |
	element applyConfiguration.
	space := BlSpace new.
	space root addChild: element.
	" the configuration is applied even it has been applied programmatically before"
	self assert: element configurationCount equals: 2.
	space root checkConfigurationPassDeeplyInSpace: space.
	" the configuration should not be runned again "
	self assert: element configurationCount equals: 2
]

{ #category : #tests }
ToWidgetConfigurationTest >> testNewElement [

	self assert: element configurationCount equals: 0

	
]

{ #category : #tests }
ToWidgetConfigurationTest >> testRequestConfigurationElementAddedInSpace [

	| space |
	space := BlSpace new.
	space root addChild: element.
	element requestConfiguration.
	space applyAllToploPhases.
	" the configuration has been requested explicitely "
	self assert: element configurationCount equals: 2.
	
	element requestConfiguration.
	space applyAllToploPhases.
	" the configuration should be runned again "
	self assert: element configurationCount equals: 3.
	
	" no configuration request between 2 checking "
	space applyAllToploPhases.
	" the configuration should ** not ** be runned again "
	self assert: element configurationCount equals: 3.

	
]

{ #category : #tests }
ToWidgetConfigurationTest >> testRequestConfigurationElementBeforeAddedInSpace [

	
	| space |
	self flag: 'This test shows a drwback of the current implementation. 
	the configuration is runned twice here whereas only one running seems useful.
	No observed increased time consuming for now'.
	element requestConfiguration.
	space := BlSpace new.
	space root addChild: element.
	space applyAllToploPhases.
	self assert: element configurationCount equals: 2.
	space applyAllToploPhases.
	" the configuration should not be runned again "
	self assert: element configurationCount equals: 2.


	
]
