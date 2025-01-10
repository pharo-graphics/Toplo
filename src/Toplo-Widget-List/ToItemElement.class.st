"
I'm used as a data item of bar element (the data items are stored in the datasource)
My bar holder refers to the element that contains the bar that contains me.

"
Class {
	#name : #ToItemElement,
	#superclass : #ToElement,
	#traits : 'TToItem',
	#classTraits : 'TToItem classTrait',
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #initialization }
ToItemElement >> defaultLayout [

	^ BlLinearLayout vertical
]
