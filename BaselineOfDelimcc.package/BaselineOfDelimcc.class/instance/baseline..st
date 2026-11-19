baselines
baseline: spec

	<baseline>
	spec for: #common do: [
			spec baseline: 'ContainersCategory' with: [ spec repository: 'github://massimo-nocentini/Containers-Category' ].

			spec
				package: 'Delimcc';
				package: 'Delimcc-Tests' ]