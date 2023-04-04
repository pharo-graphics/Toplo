Class {
	#name : #ToPanePlaceholderLayer,
	#superclass : #ToWidgetLayer,
	#category : #'Toplo-Widget-Pane'
}

{ #category : #adding }
ToPanePlaceholderLayer >> addInPane [


]

{ #category : #'api - attaching / detaching' }
ToPanePlaceholderLayer >> attachTo: aPane [ 

	super attachTo: aPane.

]

{ #category : #initialization }
ToPanePlaceholderLayer >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self when: ToPanePlaceholderShowEvent do: [ :event | self addInPane ].
	self when: ToPanePlaceholderHideEvent do: [ :event | self removePane ].
	self preventMouseEvents.

]

{ #category : #adding }
ToPanePlaceholderLayer >> removeFromPane [
]
