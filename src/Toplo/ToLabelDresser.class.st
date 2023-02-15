Class {
	#name : #ToLabelDresser,
	#superclass : #ToAbstractLabelDresser,
	#instVars : [
		'editorEventHandler',
		'textReplacedHandler'
	],
	#category : #'Toplo-Widget-Label'
}

{ #category : #'api - install/uninstall  hook' }
ToLabelDresser >> lineModeChangedIn: anElement [

	| currText |
	currText := anElement text.
	anElement removeChildren.
	self replaceInnerElementIn: anElement.
	currText ifNotNil: [anElement innerElement text: currText].
	anElement layout: anElement defaultLayout.
	anElement addChild: anElement innerElement
]

{ #category : #'api - install/uninstall  hook' }
ToLabelDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement whenLineModeChangedDo: [ self lineModeChangedIn: anElement ].
	anElement whenTextReplacedDo: [ anElement privateText: anElement text ].
	anElement whenEditableChangedDo: [
		anElement isEditable
			ifTrue: [ self switchEditable: anElement ]
			ifFalse: [ self switchReadOnly: anElement ] ]
]

{ #category : #'api - install/uninstall  hook' }
ToLabelDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	self switchReadOnly: anElement.
	anElement innerElement ifNotNil: [
		textReplacedHandler ifNotNil: [
			anElement innerElement removeEventHandler: textReplacedHandler ] ].

]

{ #category : #'api - install/uninstall  hook' }
ToLabelDresser >> replaceInnerElementIn: anElement [

	anElement innerElement ifNotNil: [
		textReplacedHandler ifNotNil: [
			anElement innerElement removeEventHandler: textReplacedHandler ] ].
	anElement innerElement: anElement defaultTextElement.
	textReplacedHandler := BlEventHandler
		                       on: ToTextReplacedEvent
		                       do: [ :evt | anElement text: evt text ].
	anElement innerElement addEventHandler: textReplacedHandler
]

{ #category : #'api - install/uninstall  hook' }
ToLabelDresser >> switchEditable: anElement [

	editorEventHandler ifNotNil: [ ^ self ].
	editorEventHandler := BlEventHandler
		                      on: BlMouseDownEvent
		                      do: [ :anEvent | 
			                      (anEvent modifiers isShift and: [ 
				                       anEvent modifiers isPrimaryModifier ]) 
				                      ifTrue: [ 
					                      anEvent consumed: true.
					                      anElement addEditor ] ].
	anElement addEventHandler: editorEventHandler
]

{ #category : #'api - install/uninstall  hook' }
ToLabelDresser >> switchReadOnly: anElement [

	editorEventHandler ifNil: [ ^ self ].
	anElement removeEventHandler: editorEventHandler.
	editorEventHandler := nil
]
