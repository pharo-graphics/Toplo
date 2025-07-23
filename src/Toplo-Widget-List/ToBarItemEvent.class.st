Class {
	#name : #ToBarItemEvent,
	#superclass : #BlEvent,
	#instVars : [
		'item'
	],
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #accessing }
ToBarItemEvent >> item [

	^ item
]

{ #category : #accessing }
ToBarItemEvent >> item: anItem [

	item := anItem
]
