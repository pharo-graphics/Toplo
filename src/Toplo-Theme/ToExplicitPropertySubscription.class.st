Class {
	#name : #ToExplicitPropertySubscription,
	#superclass : #ToAbstractPropertySubscription,
	#instVars : [
		'value'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #accessing }
ToExplicitPropertySubscription >> value [

	^ value
]

{ #category : #accessing }
ToExplicitPropertySubscription >> value: anObject [

	value := anObject
]

{ #category : #operating }
ToExplicitPropertySubscription >> valueIn: anElement [

	^ value isClosure
		  ifTrue: [ value value: anElement ]
		  ifFalse: [ value ]
]
