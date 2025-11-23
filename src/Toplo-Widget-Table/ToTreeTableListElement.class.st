Class {
	#name : #ToTreeTableListElement,
	#superclass : #ToTreeElement,
	#traits : 'TToCheckableSelectionManager',
	#classTraits : 'TToCheckableSelectionManager classTrait',
	#instVars : [
		'parentTable'
	],
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #initialization }
ToTreeTableListElement class >> initializeToRawTheme: aTheme [
	" Now setup the default label weight and the header padding "

	<toploThemeInstallerFor: #ToRawTheme>
	aTheme select: (self asTypeSelector exact: false) style: [
			aTheme
				when: ToInstallSkinEvent
				write: (aTheme property: #geometry)
				with: [ :header | BlRectangleGeometry new ] ]
]

{ #category : #accessing }
ToTreeTableListElement >> cellStateAt: anIndex [

	^ (self headerCellContainerAt: anIndex) state
]

{ #category : #accessing }
ToTreeTableListElement >> columns [

	^ self nodeManager columns
]

{ #category : #accessing }
ToTreeTableListElement >> columns: aTableColumnArray [

	self nodeManager columns: aTableColumnArray.
	self onUseCheckboxChangedWith: (aTableColumnArray anySatisfy: [ :col | col useCheckbox ])
]

{ #category : #initialization }
ToTreeTableListElement >> defaultNodeManagerClass [

	^ ToTreeTableNodeManager
]

{ #category : #accessing }
ToTreeTableListElement >> divider: aDivider movedBy: aDistance from: aStartLocation [

	self innerElement nodes do: [ :n |
		n divider: aDivider movedBy: aDistance from: aStartLocation ]
]

{ #category : #accessing }
ToTreeTableListElement >> headerCellContainerAt: anIndex [

	^ parentTable header cellContainers at: anIndex
]

{ #category : #accessing }
ToTreeTableListElement >> parentTable [

	^ parentTable
]

{ #category : #accessing }
ToTreeTableListElement >> parentTable: aTableElement [

	parentTable := aTableElement
]

{ #category : #initialization }
ToTreeTableListElement >> recordCellsWidth [

	self innerElement nodesDo: [ :n | n recordCellsWidth ]
]
