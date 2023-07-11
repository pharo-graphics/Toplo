Class {
	#name : #ToAbstractElementLook,
	#superclass : #Object,
	#instVars : [
		'first'
	],
	#category : #'Toplo-Core-Theme-Skins'
}

{ #category : #'private event handling' }
ToAbstractElementLook >> elementLookEvent: anEvent [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractElementLook >> first [

	^ first
]

{ #category : #accessing }
ToAbstractElementLook >> first: aLook [

	first := aLook
]

{ #category : #'event handling' }
ToAbstractElementLook >> installLookEvent: anEvent [

	^ self subclassResponsibility 
]

{ #category : #testing }
ToAbstractElementLook >> isMain [

	^ self subclassResponsibility 
]

{ #category : #testing }
ToAbstractElementLook >> isNull [

	^ false
]

{ #category : #accessing }
ToAbstractElementLook >> next: aLook [

	self subclassResponsibility 
]

{ #category : #removing }
ToAbstractElementLook >> removeLook: aLook previous: previousLook [

	self subclassResponsibility 
]

{ #category : #'event handling' }
ToAbstractElementLook >> uninstallLookEvent: anEvent [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractElementLook >> updateFirstWith: aLook [

	first := aLook
]
