<h1>Nextflow Pipeline for Visualization of Read Filtration</h1>

<p>This repository contains a Nextflow pipeline designed to visualize the filtration of reads using various bioinformatics tools such as <b>STAR</b>, <b>BOWTIE</b>, <b>VG</b>, <b>SORTMERNA</b>, and others.</p>

<h2>Disclaimer</h2>
<p>This is a simplified representation of the workflow which showcases my work on actual workflow during my internship. The complete workflow is hosted in a private repository due to permission restrictions.</p>

<h2>Overview</h2>
<ul>
  <li><b>Modules:</b> Each bioinformatics tool had multiple processes (e.g., filtering, assigning) organized in modular scripts.</li>
  <li><b>Subworkflows:</b> Processes for each tool were integrated into subworkflows for efficient execution and management.</li>
  <li><b>Master Workflow:</b> Subworkflows for different tools were processed in a master workflow. Log files were generated simultaneously during execution, making it challenging to handle them individually.</li>
</ul>

<h2>Key Features</h2>
<ul>
  <li><b>Operators Folder:</b> Contains Nextflow scripts that:
    <ul>
      <li>Collect log files from each bioinformatics tool.</li>
      <li>Filter and extract desired values.</li>
      <li>Aggregate and process logs into a cohesive format.</li>
    </ul>
  </li>
  <li><b>Simplified Structure:</b> Highlights core ideas without the complexity of the original workflow.</li>
</ul>

<h2>Usage</h2>
<p>This repository can serve as:</p>
<ul>
  <li>A learning resource for managing and processing log files in bioinformatics workflows.</li>
  <li>A foundation for developing workflows for similar bioinformatics projects.</li>
</ul>
