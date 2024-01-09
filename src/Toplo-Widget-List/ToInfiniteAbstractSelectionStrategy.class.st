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
ToInfiniteAbstractSelectionStrategy >> infiniteDataSourceChanged [
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

{ #category : #'selection accessing' }
ToInfiniteAbstractSelectionStrategy >> selectedIndexes [

	^ { }
]
