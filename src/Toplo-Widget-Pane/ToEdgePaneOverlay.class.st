"
I am an overlay meant to dim what is under a `ToEdgePane`. I am a `ToFloatOverlay` with my own skin, which fills me with a translucent gray.

## Examples

```
ToEdgePaneOverlay instanceDefault
```

## Usage

Nothing in Toplo creates me yet.
"
Class {
	#name : #ToEdgePaneOverlay,
	#superclass : #ToFloatOverlay,
	#category : #'Toplo-Widget-Pane-Core'
}

{ #category : #instances }
ToEdgePaneOverlay class >> instanceDefault [

	<sampleInstance>
	^ self new
]

{ #category : #skin }
ToEdgePaneOverlay >> newRawSkin [ 

	^ ToEdgePaneOverlaySkin new
]
