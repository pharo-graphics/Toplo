"
I'm a generic list 
"
Class {
	#name : #ToGenericFiniteListElement,
	#superclass : #ToBasicFiniteListElement,
	#traits : 'TToGenericListElement',
	#classTraits : 'TToGenericListElement classTrait',
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #initialization }
ToGenericFiniteListElement >> defaultNodeManager [

	^ super defaultNodeManager
		  nodeFactory: [ :holder | ToFiniteListNode new ];
		  yourself
]

{ #category : #initialization }
ToGenericFiniteListElement >> defaultNodeManagerClass [

	^ ToGenericListNodeManager 
]

{ #category : #initialization }
ToGenericFiniteListElement >> initialize [

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
ToGenericFiniteListElement >> newRawSkin [ 

	^ ToFiniteListElementSkin new
]

{ #category : #'t - generic list element' }
ToGenericFiniteListElement >> nodeBuilder: aValuable [
	"aValuable takes 3 optional args: first, the node to build, second, the dataItem and third, the holder in the list element "

	self nodeManager nodeBuilder: aValuable.
	"self reinstallFakeNodeContainer."
	self notifyDataSourceChanged
]
