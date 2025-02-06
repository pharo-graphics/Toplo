"
I am a ToTreeClassChildSelector 

As a ChildSelector, I hold the behaviour of collecting children from an Object.

I consider as children of an Object its subclasses, meaning I expect to be used when the tree structure displays classes 
"
Class {
	#name : #ToTreeClassChildSelector,
	#superclass : #ToTreeChildSelector,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeClassChildSelector >> children [

	^ dataItem subclasses asOrderedCollection 
]
