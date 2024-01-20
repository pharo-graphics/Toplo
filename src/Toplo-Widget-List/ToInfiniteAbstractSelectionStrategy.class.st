Class {
	#name : #ToInfiniteAbstractSelectionStrategy,
	#superclass : #Object,
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #'mode changing' }
ToInfiniteAbstractSelectionStrategy >> beWithoutSelection [
]

{ #category : #'selection accessing' }
ToInfiniteAbstractSelectionStrategy >> includes: anIndex [

	^ false
]

{ #category : #'data source changed' }
ToInfiniteAbstractSelectionStrategy >> onInfiniteDataSourceChanged [
]

{ #category : #'api - hooks' }
ToInfiniteAbstractSelectionStrategy >> onInstalledIn: anInfiniteElement [
]

{ #category : #'selection and shortcuts handlers' }
ToInfiniteAbstractSelectionStrategy >> onNewNode: aNode [


]

{ #category : #'api - hooks' }
ToInfiniteAbstractSelectionStrategy >> onUninstalledIn: anInfiniteElement [
]

{ #category : #initialization }
ToInfiniteAbstractSelectionStrategy >> renewSelectionModel [
]

{ #category : #'api - selection' }
ToInfiniteAbstractSelectionStrategy >> selectAll [
]

{ #category : #'selection accessing' }
ToInfiniteAbstractSelectionStrategy >> selectedIndexes [

	^ { }
]

{ #category : #accessing }
ToInfiniteAbstractSelectionStrategy >> selectionModel [

	^ nil
]

{ #category : #accessing }
ToInfiniteAbstractSelectionStrategy >> selectionModel: aSelection [
]

{ #category : #accessing }
ToInfiniteAbstractSelectionStrategy >> shiftAfterAddingAt: aStartPosition itemCount: anItemCount [

]

{ #category : #accessing }
ToInfiniteAbstractSelectionStrategy >> shiftAfterRemovingAt: aStartPosition itemCount: anItemCount [
]
