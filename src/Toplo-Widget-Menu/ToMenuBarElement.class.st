Class {
	#name : #ToMenuBarElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToBarElement',
	#classTraits : 'TToBarElement classTrait',
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToMenuBarElement >> defaultDataSource [

	^ ToInfiniteCollectionDataSource new
]

{ #category : #initialization }
ToMenuBarElement >> defaultNodeManagerClass [

	^ ToMenuNodeManager
]

{ #category : #initialization }
ToMenuBarElement >> initialize [

	super initialize.
	self nodeWrapping: true.
	self fitContent.
	self vertical: true.
	self uniformNodeWidth: true.
	self primarySelectionMode makeDisabledUnselectable: true.
	self focusability: BlFocusability ignore
]

{ #category : #skin }
ToMenuBarElement >> newRawSkin [ 

	^ ToMenuBarElementSkin new
]
