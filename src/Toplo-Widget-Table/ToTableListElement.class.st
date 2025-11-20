"
I represent the list part of the table
"
Class {
	#name : #ToTableListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToCheckableSelectionManager',
	#classTraits : 'TToCheckableSelectionManager classTrait',
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
				with: [ :header | BlInsets empty ] ]
]

{ #category : #accessing }
ToTableListElement >> columns [

	^ self nodeManager columns
]

{ #category : #accessing }
ToTableListElement >> columns: aTableColumnArray [

	self nodeManager columns: aTableColumnArray.
	self onUseCheckboxChangedWith: (aTableColumnArray anySatisfy: [ :col | col useCheckbox ])
]

{ #category : #initialization }
ToTableListElement >> defaultNodeManagerClass [

	^ ToTableNodeManager
]

{ #category : #accessing }
ToTableListElement >> divider: aDivider movedBy: aDistance from: aStartLocation [

	self innerElement nodes do: [ :n |
		n divider: aDivider movedBy: aDistance from: aStartLocation ]
]

{ #category : #initialization }
ToTableListElement >> freezeCellsWidth [

	self innerElement nodesDo: [ :n | n freezeCellsWidth ]
]
