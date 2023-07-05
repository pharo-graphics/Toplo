Class {
	#name : #ToAbstractElementLook,
	#superclass : #Object,
	#instVars : [
		'first'
	],
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'event handling' }
ToAbstractElementLook >> elementStateEvent: anEvent [

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
ToAbstractElementLook >> installStateEvent: anEvent [

	^ self subclassResponsibility 
]

{ #category : #'event handling' }
ToAbstractElementLook >> uninstallStateEvent: anEvent [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractElementLook >> updateFirstWith: aLook [

	first := aLook
]
