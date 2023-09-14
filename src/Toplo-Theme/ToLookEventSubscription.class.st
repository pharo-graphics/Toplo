Class {
	#name : #ToLookEventSubscription,
	#superclass : #Object,
	#instVars : [
		'lookEventClasses'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #testing }
ToLookEventSubscription >> canReceiveEvent: aLookEvent [ 

	^ self lookEventClasses includes: aLookEvent class 
]

{ #category : #testing }
ToLookEventSubscription >> isPropertyBased [

	^ false
]

{ #category : #accessing }
ToLookEventSubscription >> lookEventClasses [

	^ lookEventClasses
]

{ #category : #accessing }
ToLookEventSubscription >> lookEventClasses: aLookEventClassCollection [

	lookEventClasses := aLookEventClassCollection
]

{ #category : #operating }
ToLookEventSubscription >> receiveLookEvent: aLookEvent [

	self subclassResponsibility 
]
