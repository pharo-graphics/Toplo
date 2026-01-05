Class {
	#name : #ToListItemEvent,
	#superclass : #BlEvent,
	#instVars : [
		'item'
	],
	#category : #'Toplo-Widget-List-ItemList'
}

{ #category : #accessing }
ToListItemEvent >> item [

	^ item
]

{ #category : #accessing }
ToListItemEvent >> item: anItem [

	item := anItem
]
