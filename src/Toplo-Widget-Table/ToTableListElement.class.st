"
I represent the list part of the table
"
Class {
	#name : #ToTableListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToTableListElement',
	#classTraits : 'TToTableListElement classTrait',
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #initialization }
ToTableListElement class >> initializeToRawTheme: aTheme [
	" Now setup the default label weight and the header padding "

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #geometry)
				with: [ :header | BlRectangleGeometry new ].
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #padding)
				with: [ :e |
						BlInsets empty ] ].

	aTheme select: #cellCheckbox asIdSelector style: [
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #padding)
				with: [ :cbox |
					BlInsets horizontal: (cbox valueOfTokenNamed: #'padding-XS') ] ]
]

{ #category : #initialization }
ToTableListElement >> defaultNodeManagerClass [

	^ ToTableNodeManager
]

{ #category : #initialization }
ToTableListElement >> initialize [

	super initialize.
	self initializeScrollBar
]

{ #category : #initialization }
ToTableListElement >> initializeScrollBar [

	| vscrollBar |
	vscrollBar := BlVerticalScrollbarElement new.
	vscrollBar constraintsDo: [ :c |
			c ignoreByLayout.
			c margin: (BlInsets left: 10).
			c ignored horizontal alignRight.
			c ignored vertical alignBottom ].
	vscrollBar attachTo: self innerElement.
	vscrollBar elevation: (BlRelativeElevation elevation: 20).
	self addChild: vscrollBar
]
