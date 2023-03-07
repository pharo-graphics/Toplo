"
I am a Function that do nothing to use a Null Object Pattern.
	
Example (Should only be create by a ToFTTableMorph)
-------------------------------------------------

ToFTNilFunction table: (ToFTTableMorph with: (1 to: 200))

"
Class {
	#name : #ToFTNilFunction,
	#superclass : #ToFTFunction,
	#category : #'Toplo-FastTable-Functions'
}

{ #category : #accessing }
ToFTNilFunction >> beExplicit [
	"Do nothing"
]

{ #category : #protocol }
ToFTNilFunction >> disable [
	"Do nothing"
]

{ #category : #testing }
ToFTNilFunction >> isExplicit [
	^ false
]

{ #category : #'event handling' }
ToFTNilFunction >> keyStroke: anEvent [
	"Do nothing"
	^ false
]

{ #category : #initialization }
ToFTNilFunction >> reset [
]

{ #category : #private }
ToFTNilFunction >> resizeContainerFrom: topLefPoint to: bottomRightPoint [
	"I do not change the size of the container."

	^ topLefPoint corner: bottomRightPoint
]

{ #category : #private }
ToFTNilFunction >> resizeWidget [
	"Do nothing"
]

{ #category : #accessing }
ToFTNilFunction >> showWidget [
	"Do nothing"
]
