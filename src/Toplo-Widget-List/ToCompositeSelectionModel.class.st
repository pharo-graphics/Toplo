Class {
	#name : #ToCompositeSelectionModel,
	#superclass : #ToSelectionModel,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #accessing }
ToCompositeSelectionModel >> recordSubSelectionModel: aSelectionModel [

	self subSelectionModelIndex recordSubSelectionModel: aSelectionModel
]

{ #category : #updating }
ToCompositeSelectionModel >> resetAll [

	super resetAll.
	self subSelectionModelIndex resetAll
]

{ #category : #accessing }
ToCompositeSelectionModel >> subSelectionModelIndex [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToCompositeSelectionModel >> subSelectionModelWithId: anUniqueId [

	^ self subSelectionModelIndex subSelectionModelWithId: anUniqueId
]

{ #category : #updating }
ToCompositeSelectionModel >> transferSelectionFromIndex: anIndex toIndex: targetIndex in: anotherSelectionModel [

	super
		transferSelectionFromIndex: anIndex
		toIndex: targetIndex
		in: anotherSelectionModel.
	self subSelectionModelIndex selectionModelsDo: [ :dst |
		(anotherSelectionModel subSelectionModelWithId: dst uniqueId)
			ifNotNil: [ :other |
				(dst containsIndex: anIndex)
					ifTrue: [ other selectIndex: targetIndex ]
					ifFalse: [ other deselectIndex: targetIndex ] ] ]
]

{ #category : #accessing }
ToCompositeSelectionModel >> unrecordSubSelectionModel: aSelectionModel [

	self subSelectionModelIndex unrecordSubSelectionModel: aSelectionModel
]
