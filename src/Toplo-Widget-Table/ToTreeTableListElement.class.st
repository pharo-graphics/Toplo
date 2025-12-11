Class {
	#name : #ToTreeTableListElement,
	#superclass : #ToTreeElement,
	#traits : 'TToTableListElement',
	#classTraits : 'TToTableListElement classTrait',
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #initialization }
ToTreeTableListElement class >> initializeToRawTheme: aTheme [
	" Now setup the default label weight and the header padding "

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #padding)
				with: [ :e | BlInsets empty ].
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #geometry)
				with: [ :header | BlRectangleGeometry new ] ]
]

{ #category : #initialization }
ToTreeTableListElement >> defaultNodeManagerClass [

	^ ToTreeTableNodeManager
]
