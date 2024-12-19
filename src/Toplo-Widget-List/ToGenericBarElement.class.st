Class {
	#name : #ToGenericBarElement,
	#superclass : #ToGenericListElement,
	#traits : 'TToBarElement',
	#classTraits : 'TToBarElement classTrait',
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #initialization }
ToGenericBarElement >> defaultNodeManagerClass [

	^ ToGenericBarNodeManager 
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
	self matchParent.
	self configureLayout
]

{ #category : #'t - orientable - accessing' }
ToGenericBarElement >> layoutStrategy [

	^ self layout

	
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
	self reinstallFakeNode.
	self notifyDataSourceChanged
]

{ #category : #accessing }
ToGenericBarElement >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	super nodeFactory: aValuable.
	self notifyDataSourceChanged
]

{ #category : #accessing }
ToGenericBarElement >> nodeHolderClass: aNodeHolderClass [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	super nodeHolderClass: aNodeHolderClass.
	self notifyDataSourceChanged
]
