"
I represent the list part of the table
"
Class {
	#name : #ToTableListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToCheckableSelectionManager + TToTableListElement',
	#classTraits : 'TToCheckableSelectionManager classTrait + TToTableListElement classTrait',
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
				with: [ :header | BlRectangleGeometry new ] ].

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
