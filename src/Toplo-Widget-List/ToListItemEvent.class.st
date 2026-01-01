Class {
	#name : #ToListItemEvent,
	#superclass : #BlEvent,
	#instVars : [
		'item'
	],
	#category : #'Toplo-Widget-List-ItemFiniteList'
}

{ #category : #accessing }
ToListItemEvent >> item [

	^ item
]

{ #category : #accessing }
ToListItemEvent >> item: anItem [

	item := anItem
]
