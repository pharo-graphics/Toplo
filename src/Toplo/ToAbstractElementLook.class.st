Class {
	#name : #ToAbstractElementLook,
	#superclass : #Object,
	#category : #'Toplo-Theme-Skins-Looks'
}

{ #category : #'event handling' }
ToAbstractElementLook >> elementStateEvent: anEvent [

	^ self subclassResponsibility 
]

{ #category : #'event handling' }
ToAbstractElementLook >> installStateEvent: anEvent [

	^ self subclassResponsibility 
]

{ #category : #'event handling' }
ToAbstractElementLook >> uninstallStateEvent: anEvent [

	^ self subclassResponsibility 
]
