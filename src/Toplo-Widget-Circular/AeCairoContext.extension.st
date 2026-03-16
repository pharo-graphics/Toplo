Extension { #name : #AeCairoContext }

{ #category : #'*Toplo-Widget-Circular' }
AeCairoContext >> annulusSectorCenter: aPoint from: radiansStart to: radiansStop innerRadius: innerRadius outerRadius: outerRadius gap: aGap [
	"Precondition: radiansStart < radiansStop"

	| outerOffset innerOffset outerStart innerStart outerEnd innerEnd |
	outerOffset := aGap / outerRadius.
	innerOffset := aGap / innerRadius.

	outerStart := radiansStart + (outerOffset / 2).
	innerStart := radiansStart + (innerOffset / 2).
	outerEnd := radiansStop - (outerOffset / 2).
	innerEnd := radiansStop - (innerOffset / 2).

	self
		arcCenterX: aPoint x
		centerY: aPoint y
		radius: outerRadius
		startAngle: outerStart
		endAngle: outerEnd.
	self
		arcNegativeCenterX: aPoint x
		centerY: aPoint y
		radius: innerRadius
		startAngle: innerEnd
		endAngle: innerStart.
	self closePath
]
