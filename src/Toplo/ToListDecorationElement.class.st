Class {
	#name : #ToListDecorationElement,
	#superclass : #OBlElement,
	#instVars : [
		'listElement'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListDecorationElement >> borderColor [

	^ Color gray
]

{ #category : #accessing }
ToListDecorationElement >> borderWidth [

	^ 1
]

{ #category : #accessing }
ToListDecorationElement >> defaultBorder [

	^ BlBorder paint: self borderColor width: self borderWidth
]

{ #category : #accessing }
ToListDecorationElement >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : #initialization }
ToListDecorationElement >> initialize [ 

	super initialize.
	self layout: self defaultLayout.
	self geometry: self defaultGeometry.
	self background: Color transparent.
	self border:	self defaultBorder.
	self constraintsDo: [ :c | c ignoreByLayout ].
	self outskirts: BlOutskirts inside

]

{ #category : #accessing }
ToListDecorationElement >> listElement [

	^ listElement
]

{ #category : #accessing }
ToListDecorationElement >> listElement: aListElement [

	listElement := aListElement
]
