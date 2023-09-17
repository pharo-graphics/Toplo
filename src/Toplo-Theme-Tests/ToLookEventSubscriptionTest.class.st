"
A ToPropertySubscriptionTest is a test class for testing the behavior of ToPropertySubscription
"
Class {
	#name : #ToLookEventSubscriptionTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-Skin'
}

{ #category : #tests }
ToLookEventSubscriptionTest >> testWithNoWriters [

	| eventSubscription |
	eventSubscription := ToLookEventSubscription new.
	eventSubscription eventClass: ToInstallLookEvent.
	self assert: (eventSubscription canReceiveEvent: ToInstallLookEvent new).
	self assert: (eventSubscription canReceiveEvent: ToHoveredLookEvent new) not.
	eventSubscription receiveEvent: ToInstallLookEvent new
]

{ #category : #tests }
ToLookEventSubscriptionTest >> testWithWithOneWriter [

	| eventSubscription target propWriter |
	propWriter := ToPropertyWriterForTest new propName: #background; value: Color blue.
	target := ToElement new.
	eventSubscription := ToLookEventSubscription new.
	eventSubscription eventClass: ToInstallLookEvent.
	eventSubscription writers: { propWriter }.
	eventSubscription receiveEvent: (ToInstallLookEvent new currentTarget: target).
	self assert: target background paint color equals: Color blue.
]
