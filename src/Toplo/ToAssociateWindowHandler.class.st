Class {
	#name : #ToAssociateWindowHandler,
	#superclass : #Object,
	#instVars : [
		'name',
		'factory',
		'currentWindow',
		'elementEventHandler',
		'windowEventHandler',
		'element'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToAssociateWindowHandler >> currentWindow [

	^ currentWindow
]

{ #category : #accessing }
ToAssociateWindowHandler >> currentWindow: AWindowElement [

	currentWindow := AWindowElement
]

{ #category : #'window handling' }
ToAssociateWindowHandler >> dissociateFromWindow [

	currentWindow associateElement: nil.
	element removeEventHandler: elementEventHandler.
	elementEventHandler associateWindow: nil
]

{ #category : #accessing }
ToAssociateWindowHandler >> element [

	^ element
]

{ #category : #accessing }
ToAssociateWindowHandler >> element: anElement [

	element := anElement
]

{ #category : #accessing }
ToAssociateWindowHandler >> elementEventHandler [

	^ elementEventHandler
]

{ #category : #accessing }
ToAssociateWindowHandler >> elementEventHandler: anEventHandler [

	elementEventHandler := anEventHandler
]

{ #category : #accessing }
ToAssociateWindowHandler >> factory [

	^ factory
]

{ #category : #accessing }
ToAssociateWindowHandler >> factory: aWindowFactoryValuable [

	factory := aWindowFactoryValuable
]

{ #category : #testing }
ToAssociateWindowHandler >> hasAssociateWindow [

	^ currentWindow notNil
]

{ #category : #accessing }
ToAssociateWindowHandler >> name [

	^ name
]

{ #category : #accessing }
ToAssociateWindowHandler >> name: aSymbol [

	name := aSymbol
]

{ #category : #'window handling' }
ToAssociateWindowHandler >> newAssociateWindow [

	currentWindow ifNotNil: [
		Error signal: 'Asking for a associate window building twice' ].
	currentWindow := self factory cull: self.
	currentWindow associateElement: element.
	elementEventHandler associateWindow: currentWindow.
	element addEventHandler: elementEventHandler.
	^ currentWindow
]

{ #category : #accessing }
ToAssociateWindowHandler >> windowEventHandler [

	^ windowEventHandler
]

{ #category : #accessing }
ToAssociateWindowHandler >> windowEventHandler: anEventHandler [

	windowEventHandler := anEventHandler
]
