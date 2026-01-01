Class {
	#name : #ToBasicWrappedListElement,
	#superclass : #ToBasicListElement,
	#category : #'Toplo-Widget-List-WrappedList'
}

{ #category : #initialization }
ToBasicWrappedListElement >> defaultDataAccessor [

	^ ToWrappedListDataAccessor new
]

{ #category : #initialization }
ToBasicWrappedListElement >> defaultNodeManagerClass [

	^ ToWrappedListNodeManager
]

{ #category : #'instance creation' }
ToBasicWrappedListElement >> sieveClass [

	^ ToWrappedListElementSieve
]
