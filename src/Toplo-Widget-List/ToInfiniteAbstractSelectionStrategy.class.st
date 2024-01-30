Class {
	#name : #ToInfiniteAbstractSelectionStrategy,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventDispatcher'
	],
	#category : #'Toplo-Widget-List-Selection'
}

{ #category : #'mode changing' }
ToInfiniteAbstractSelectionStrategy >> beWithoutSelection [
]

{ #category : #'selection event dispatching' }
ToInfiniteAbstractSelectionStrategy >> dispatchSelectionChangedAfter: aBlock [
]

{ #category : #'selection event dispatching' }
ToInfiniteAbstractSelectionStrategy >> dispatchSelectionDirtyAfter: aBlock [


]

{ #category : #'selection event dispatching' }
ToInfiniteAbstractSelectionStrategy >> dispatchStrongSelectionChanged [


]

{ #category : #'event management accessing' }
ToInfiniteAbstractSelectionStrategy >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #'selection accessing' }
ToInfiniteAbstractSelectionStrategy >> includes: anIndex [

	^ false
]

{ #category : #initialization }
ToInfiniteAbstractSelectionStrategy >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self.

]

{ #category : #'data source change' }
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

{ #category : #'data source change' }
ToInfiniteAbstractSelectionStrategy >> shiftAfterAddingAt: aStartPosition itemCount: anItemCount [

]

{ #category : #'data source change' }
ToInfiniteAbstractSelectionStrategy >> shiftAfterRemovingAt: aStartPosition itemCount: anItemCount [
]
