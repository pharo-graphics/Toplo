Class {
	#name : #ToElementProperty,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Toplo-Core-Properties'
}

{ #category : #'syntactic sugar' }
ToElementProperty >> clickedValue: anObjectOrBlock [

	^ self when: ToClickedLookEvent value: anObjectOrBlock
]

{ #category : #'syntactic sugar' }
ToElementProperty >> disabledValue: anObjectOrBlock [

	^ self when: ToDisabledLookEvent value: anObjectOrBlock
]

{ #category : #'syntactic sugar' }
ToElementProperty >> focusedValue: anObjectOrBlock [

	^ self when: ToFocusedLookEvent value: anObjectOrBlock
]

{ #category : #'syntactic sugar' }
ToElementProperty >> hoveredValue: anObjectOrBlock [

	^ self when: ToHoveredLookEvent value: anObjectOrBlock
]

{ #category : #'syntactic sugar' }
ToElementProperty >> initialValue: anObjectOrBlock [

	^ self when: ToInitialLookEvent value: anObjectOrBlock
]

{ #category : #'syntactic sugar' }
ToElementProperty >> installValue: anObjectOrBlock [

	^ self when: ToInstallLookEvent value: anObjectOrBlock
]

{ #category : #comparing }
ToElementProperty >> isConficting: anotherProperty [

	" two properties with the same name are in conflict  "
	self name = anotherProperty name ifFalse: [ ^ false ].
	^ true
]

{ #category : #'syntactic sugar' }
ToElementProperty >> leavedValue: anObjectOrBlock [

	^ self when: ToLeavedLookEvent value: anObjectOrBlock
]

{ #category : #accessing }
ToElementProperty >> name [

	^ name
]

{ #category : #accessing }
ToElementProperty >> name: anObject [

	name := anObject
]

{ #category : #'syntactic sugar' }
ToElementProperty >> openedValue: anObjectOrBlock [

	^ self when: ToOpenedLookEvent value: anObjectOrBlock
]

{ #category : #'syntactic sugar' }
ToElementProperty >> pressedValue: anObjectOrBlock [

	^ self when: ToPressedLookEvent value: anObjectOrBlock
]

{ #category : #operating }
ToElementProperty >> read: anObject [

	self subclassResponsibility 
]

{ #category : #'syntactic sugar' }
ToElementProperty >> selectedValue: anObjectOrBlock [

	^ self when: ToSelectedLookEvent value: anObjectOrBlock
]

{ #category : #'syntactic sugar' }
ToElementProperty >> uninstallValue: anObjectOrBlock [

	^ self when: ToUninstallLookEvent value: anObjectOrBlock
]

{ #category : #declaring }
ToElementProperty >> when: aLookEventClass value: aBlockOrObject [

	^ self when: aLookEventClass value: aBlockOrObject animation: nil
]

{ #category : #declaring }
ToElementProperty >> when: aLookEventClass value: aBlockOrObject animation: anAnimation [

	^ ToPropertySubscriptionDep new property: self; value: aBlockOrObject; eventClass: aLookEventClass; animation: anAnimation;yourself 
]

{ #category : #operating }
ToElementProperty >> write: anPropertyValue to: anObject [

	self subclassResponsibility 
]
