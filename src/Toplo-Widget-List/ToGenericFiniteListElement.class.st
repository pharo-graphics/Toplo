Class {
	#name : #ToGenericFiniteListElement,
	#superclass : #ToGenericListElement,
	#traits : 'TToConfigurableBarElement + TToFiniteListElement',
	#classTraits : 'TToConfigurableBarElement classTrait + TToFiniteListElement classTrait',
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #initialization }
ToGenericFiniteListElement >> defaultNodeManagerClass [

	^ ToGenericFiniteListNodeManager 
]

{ #category : #initialization }
ToGenericFiniteListElement >> initialize [

	super initialize.
	self initializeAsBarElement.
	self primarySelectionMode selectionOption
		grouped: false;
		beneath: true;
		triggerSelectionState: true.
	self contextMenuSelectionMode selectionOption
		grouped: false;
		beneath: false.
	self matchParent
]

{ #category : #skin }
ToGenericFiniteListElement >> newRawSkin [ 

	^ ToBarElementSkin new
]

{ #category : #accessing }
ToGenericFiniteListElement >> nodeBuilder: aValuable [
	"aValuable takes 3 optional args: first, the node to build, second, the dataItem and third, the holder in the list element "

	super nodeBuilder: aValuable.
	self nodeManager fakeDataItem: nil.
	self reinstallFakeNodeContainer.
	self notifyDataSourceChanged
]

{ #category : #accessing }
ToGenericFiniteListElement >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	super nodeFactory: aValuable.
	self notifyDataSourceChanged
]
