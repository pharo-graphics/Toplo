Class {
	#name : #ToGenericBarElement,
	#superclass : #ToGenericListElement,
	#traits : 'TToConfigurableBarElement + TToBarElement',
	#classTraits : 'TToConfigurableBarElement classTrait + TToBarElement classTrait',
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #initialization }
ToGenericBarElement >> defaultNodeManagerClass [

	^ ToGenericBarNodeManager 
]

{ #category : #accessing }
ToGenericBarElement >> fakeNodeContainer [

	^ self innerElement fakeNodeContainer
]

{ #category : #initialization }
ToGenericBarElement >> initialize [

	super initialize.
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
ToGenericBarElement >> newRawSkin [ 

	^ ToBarElementSkin new
]

{ #category : #accessing }
ToGenericBarElement >> nodeBuilder: aValuable [
	"aValuable takes 3 optional args: first, the node to build, second, the dataItem and third, the holder in the list element "

	super nodeBuilder: aValuable.
	self nodeManager fakeDataItem: nil.
	self reinstallFakeNodeContainer.
	self notifyDataSourceChanged
]

{ #category : #accessing }
ToGenericBarElement >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	super nodeFactory: aValuable.
	self notifyDataSourceChanged
]
