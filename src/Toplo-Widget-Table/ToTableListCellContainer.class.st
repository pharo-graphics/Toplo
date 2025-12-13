Class {
	#name : #ToTableListCellContainer,
	#superclass : #ToTableCellContainer,
	#instVars : [
		'tableNodeHolder'
	],
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #'instance creation' }
ToTableListCellContainer class >> holder: aTableNodeHolder column: aColumn [

	^ self new
		  holder: aTableNodeHolder column: aColumn;
		  yourself
]

{ #category : #accessing }
ToTableListCellContainer >> columnIndex [

	^ self parentTable indexOfColumn: column
]

{ #category : #accessing }
ToTableListCellContainer >> holder: aTableNodeHolder [

	tableNodeHolder := aTableNodeHolder 
]

{ #category : #accessing }
ToTableListCellContainer >> holder: aTableNodeHolder column: aColumn [

	self holder: aTableNodeHolder.
	self initializeWithColumn: aColumn
]

{ #category : #'t - triplet container - instance creation' }
ToTableListCellContainer >> newMiddleContainer [ 

	^ column cellFactory cull: tableNodeHolder
]

{ #category : #'instance creation' }
ToTableListCellContainer >> newRawSkin [ 

	^ ToTableListCellContainerSkin new
]

{ #category : #accessing }
ToTableListCellContainer >> nodeDepth [

	^ tableNodeHolder nodeDepth
]

{ #category : #accessing }
ToTableListCellContainer >> parentTable [

	^ self tableListEement parentTable
]

{ #category : #accessing }
ToTableListCellContainer >> tableListEement [

	^ tableNodeHolder listElement 
]

{ #category : #accessing }
ToTableListCellContainer >> tableNodeHolder [

	^ tableNodeHolder
]
