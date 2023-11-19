Class {
	#name : 'ToNotebook',
	#superclass : 'ToPane',
	#instVars : [
		'rebuildPaneOnSelect',
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
	self addButton: but
]

{ #category : 'accessing' }
ToNotebook >> body [

	^ body
]

{ #category : 'accessing' }
ToNotebook >> body: anObject [

	body := anObject
]

{ #category : 'accessing' }
ToNotebook >> header [

	^ header
]

{ #category : 'accessing' }
ToNotebook >> header: anObject [

	header := anObject
]

{ #category : 'initialization' }
ToNotebook >> initialize [

	super initialize.
	rebuildPaneOnSelect := false.
	self beVertical.
	self matchParent.
	header := ToNotebookHeader horizontal.
	body := ToPane vertical matchParent.
	self addChild: header as: #header.
	self addChild: body as: #body
]

{ #category : 'adding-removing' }
ToNotebook >> onButtonRemoved: aButton [


]

{ #category : 'accessing' }
ToNotebook >> preservePaneOnSelect [

	^ self rebuildPaneOnSelect not
]

{ #category : 'accessing' }
ToNotebook >> preservePaneOnSelect: aBoolean [

	self rebuildPaneOnSelect: aBoolean not
]

{ #category : 'accessing' }
ToNotebook >> rebuildPaneOnSelect [

	^ rebuildPaneOnSelect
]

{ #category : 'accessing' }
ToNotebook >> rebuildPaneOnSelect: aBoolean [

	rebuildPaneOnSelect := aBoolean
]
