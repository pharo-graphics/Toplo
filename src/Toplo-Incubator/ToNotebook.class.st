Class {
	#name : 'ToNotebook',
	#superclass : 'ToPane',
	#instVars : [
		'header',
		'body'
	],
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'adding-removing' }
ToNotebook >> addButton: aButton [

	header addChild: aButton
]

{ #category : 'adding-removing' }
ToNotebook >> addButtonWithText: aText withPaneBuilder: aValuable [

	| but |
	but := ToNotebookButton new labelText: aText asString.
	but paneBuilder: aValuable.
	header addChild: but
]

{ #category : 'accessing' }
ToNotebook >> body [

	^ body
]

{ #category : 'accessing' }
ToNotebook >> header [

	^ header
]

{ #category : 'initialization' }
ToNotebook >> initialize [

	super initialize.
	self beVertical.
	self matchParent.
	header := ToNotebookHeader horizontal.
	body := ToNotebookBody vertical matchParent.
	self addChild: header as: #header.
	self addChild: body as: #body
]

{ #category : 'adding-removing' }
ToNotebook >> removeButton: aButton [

	header removeChild: aButton
]
