Class {
	#name : #ToBarElement,
	#superclass : #ToGenericListElement,
	#traits : 'TToBarElement',
	#classTraits : 'TToBarElement classTrait',
	#category : #'Toplo-Widget-List-Core-BarElement'
}

{ #category : #initialization }
ToBarElement >> defaultDataSource [

	^ ToInfiniteCollectionDataSource new
]

{ #category : #initialization }
ToBarElement >> defaultNodeManagerClass [

	^ ToGenericBarNodeManager 
]

{ #category : #layout }
ToBarElement >> haveInvisibleNodes: theInvisibleNodes [

	
]

{ #category : #initialization }
ToBarElement >> initialize [

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

{ #category : #initialization }
ToBarElement >> initializeInnerElement [

	super initializeInnerElement.
	self installFakeNode
]

{ #category : #skin }
ToBarElement >> newRawSkin [ 

	^ ToBarElementSkin new
]

{ #category : #accessing }
ToBarElement >> nodeBuilder: aValuable [
	"aValuable takes 3 optional args: first, the node to build, second, the dataItem and third, the holder in the list element "

	super nodeBuilder: aValuable.
	self notifyDataSourceChanged
]

{ #category : #accessing }
ToBarElement >> nodeFactory: aValuable [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	super nodeFactory: aValuable.
	self notifyDataSourceChanged
]

{ #category : #accessing }
ToBarElement >> nodeHolderClass: aNodeHolderClass [
	" aValuable that takes a node holder as unique argument and which running results in a new node "

	super nodeHolderClass: aNodeHolderClass.
	self notifyDataSourceChanged
]

{ #category : #layout }
ToBarElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext
]

{ #category : #initialization }
ToBarElement >> uninstallFakeNode [

	self innerElement uninstallFakeNode
]
