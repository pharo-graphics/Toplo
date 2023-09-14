Class {
	#name : #ToAutoPropertySubscription,
	#superclass : #ToAbstractPropertySubscription,
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #accessing }
ToAutoPropertySubscription >> property: aLookProperty [

	super property: aLookProperty.
	self lookEventClasses: aLookProperty lookEventClasses
]
