Class {
	#name : #ToEmptySkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Empty'
}

{ #category : #'event handling' }
ToEmptySkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
			e layout alignCenter.
			(e hasStamp: #waiting) ifTrue: [
					e installInnerImage: (self waitingAnimationIn: e).
					e image extent: (e valueOfTokenNamed: #'empty-image-size') asPoint].
			(e hasStamp: #box) ifTrue: [
					e installInnerImage: (e valueOfTokenNamed: #empty_box).
					e image
						extent: (e valueOfTokenNamed: #'empty-image-size') asPoint;
						innerImageColor:
							(e valueOfTokenNamed: #'color-text-placeholder') ] ]
]

{ #category : #accessing }
ToEmptySkin >> refresh: aStadium inSector: anAnnulusSector [

	| midAngle startAngle endAngle containerRadius inner outer length |
	startAngle := anAnnulusSector startAngle.
	endAngle := anAnnulusSector endAngle.

	midAngle := startAngle + endAngle / 2.

	containerRadius := anAnnulusSector bounds extent min / 2.

	inner := anAnnulusSector innerRadius * containerRadius.
	outer := anAnnulusSector outerRadius * containerRadius.

	length := outer - inner.

	aStadium width: length.
	aStadium transformDo: [ :t | t rotateBy: midAngle ]
]

{ #category : #accessing }
ToEmptySkin >> waitingAnimationIn: anEmpty [

	| container animation |
	container := ToAnnulusCircularElement new.
	container geometry: BlCircleGeometry new.
	container extent:
		(anEmpty valueOfTokenNamed: #'empty-image-size') asPoint.
	container innerRadius: 0.28.
	container outerRadius: 1.0.

	8 timesRepeat: [
			| sector stadium |
			sector := ToAnnulusSectorElement new.
			stadium := BlElement new
				           geometry: BlStadiumGeometry new;
				           background:
					           (anEmpty valueOfTokenNamed: #'color-text-placeholder');
				           height: 5;
				           yourself.
			sector addChild: stadium.
			stadium constraintsDo: [ :c |
					c ignoreByLayout.
					c anchors add:
						(c anchors centerAnchor on: c anchors parent centroidAnchor) ].
			container addChild: sector ].

	animation := BlNumberTransition new
		             beInfinite;
		             from: 0;
		             to: 360;
		             duration: 3 seconds;
		             onStepDo: [ :number :anElement |
			             anElement startAngle: number ].
	container addAnimation: animation.
	container whenLayoutedDo: [
			container childrenDo: [ :sector |
				self refresh: sector firstChild inSector: sector ] ].
	^ container
]
