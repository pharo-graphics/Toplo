Class {
	#name : #ToTableListCellContainer,
	#superclass : #ToTableCellContainer,
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #'instance creation' }
ToTableListCellContainer class >> column: aColumn holder: aTableNodeHolder [ 

	^ self new
		  column: aColumn holder: aTableNodeHolder;
		  yourself
]

{ #category : #initialization }
ToTableListCellContainer >> column: aColumn holder: aTableNodeHolder [ 

	self holder: aTableNodeHolder.
	self initializeWithColumn: aColumn
]

{ #category : #accessing }
ToTableListCellContainer >> columnIndex [

	^ self parentTable indexOfColumn: column
]

{ #category : #'t - triplet container - instance creation' }
ToTableListCellContainer >> newMiddleContainer [ 

	^ column cellFactory cull: self holder
]

{ #category : #skin }
ToTableListCellContainer >> newRawSkin [ 

	^ ToTableListCellContainerSkin new
]

{ #category : #accessing }
ToTableListCellContainer >> nodeDepth [

	^ self holder nodeDepth
]

{ #category : #accessing }
ToTableListCellContainer >> parentTable [

	^ self tableListEement parentTable
]

{ #category : #accessing }
ToTableListCellContainer >> tableListEement [

	^ self holder listElement 
]
