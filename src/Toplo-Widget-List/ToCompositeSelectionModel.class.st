Class {
	#name : #ToCompositeSelectionModel,
	#superclass : #ToSelectionModel,
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #copying }
ToCompositeSelectionModel >> copySelectionFrom: anotherSelectionModel [

	super copySelectionFrom: anotherSelectionModel.
	anotherSelectionModel subSelectionModelIndex valuesDo: [ :src |
		(self subSelectionModelWithId: src uniqueId)
			ifNotNil: [ :dst | dst copySelectionFrom: src ] ]
]

{ #category : #accessing }
ToCompositeSelectionModel >> recordSubSelectionModel: aSelectionModel [

	self subSelectionModelIndex at: aSelectionModel uniqueId put: aSelectionModel
]

{ #category : #updating }
ToCompositeSelectionModel >> resetAll [

	super resetAll.
	self subSelectionModelIndex valuesDo: [ :dst | dst resetAll ]
]

{ #category : #accessing }
ToCompositeSelectionModel >> subSelectionModelIndex [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToCompositeSelectionModel >> subSelectionModelWithId: anUniqueId [

	^ self subSelectionModelIndex at: anUniqueId ifAbsent: [  ]
]

{ #category : #updating }
ToCompositeSelectionModel >> transferSelectionFromIndex: anIndex toIndex: targetIndex in: anotherSelectionModel [

	super
		transferSelectionFromIndex: anIndex
		toIndex: targetIndex
		in: anotherSelectionModel.
	self subSelectionModelIndex valuesDo: [ :dst |
		(anotherSelectionModel subSelectionModelWithId: dst uniqueId)
			ifNotNil: [ :other |
				(dst containsIndex: anIndex)
					ifTrue: [ other selectIndex: targetIndex ]
					ifFalse: [ other deselectIndex: targetIndex ] ] ]
]

{ #category : #accessing }
ToCompositeSelectionModel >> unrecordSubSelectionModel: aSelectionModel [

	self subSelectionModelIndex removeKey: aSelectionModel uniqueId
]
