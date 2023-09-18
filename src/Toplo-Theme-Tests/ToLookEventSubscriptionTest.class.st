"
A ToPropertySubscriptionTest is a test class for testing the behavior of ToPropertySubscription
"
Class {
	#name : #ToLookEventSubscriptionTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-SkinDep'
}

{ #category : #tests }
ToLookEventSubscriptionTest >> testWithNoWriters [

	| eventSubscription |
	eventSubscription := ToLookEventSubscriptionDep2 new.
	eventSubscription eventClass: ToInstallLookEvent.
	self assert: (eventSubscription canReceiveEvent: ToInstallLookEvent new).
	self assert: (eventSubscription canReceiveEvent: ToHoveredLookEvent new) not.
	eventSubscription receiveEvent: ToInstallLookEvent new
]

{ #category : #tests }
ToLookEventSubscriptionTest >> testWithOneWriter [

	| eventSubscription target propWriter |
	propWriter := ToPropertyWriterForTest new propName: #background; value: Color blue.
	target := BlElement new.
	eventSubscription := ToLookEventSubscriptionDep2 new.
	eventSubscription eventClass: ToInstallLookEvent.
	eventSubscription writers: { propWriter }.
	eventSubscription receiveEvent: (ToInstallLookEvent new currentTarget: target).
	self assert: target background paint color equals: Color blue.
]

{ #category : #tests }
ToLookEventSubscriptionTest >> testWithTwoWriters [

	| eventSubscription target propWriter1 propWriter2 |
	propWriter1 := ToPropertyWriterForTest new propName: #background; value: Color blue.
	propWriter2 := ToPropertyWriterForTest new propName: #border; value: Color red.
	target := BlElement new.
	eventSubscription := ToLookEventSubscriptionDep2 new.
	eventSubscription eventClass: ToInstallLookEvent.
	eventSubscription writers: { propWriter1.  propWriter2.}.
	eventSubscription receiveEvent: (ToInstallLookEvent new currentTarget: target).
	self assert: target background paint color equals: Color blue.	
	self assert: target border paint color equals: Color red.
]

{ #category : #tests }
ToLookEventSubscriptionTest >> testWithWithDefaultEvent [

	| eventSubscription target propWriter |
	propWriter := ToPropertyWriterForTest new propName: #background; value: Color blue.
	target := BlElement new.
	eventSubscription := ToLookEventSubscriptionDep2 new.
	eventSubscription writers: { propWriter }.
	eventSubscription receiveEvent: (ToInstallLookEvent new currentTarget: target).
	self assert: target background paint color equals: Color blue.
]
